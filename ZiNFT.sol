// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.0;

// We first import some OpenZeppelin Contracts.
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

// We inherit the contract we imported. This means we'll have access
// to the inherited contract's methods.
contract ZiNFT is ERC721URIStorage {

  // Magic given to us by OpenZeppelin to help us keep track of tokenIds.
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  string[] jsonipfs = [
    "ipfs://QmVD8U23zwEvNFuY7eqaCtQoNecMkAkwLx9iTPMMSLe61L",
    "ipfs://QmdjQyPMcFcyjquocQAzJnjvDc9zUGcMxXLzba3kqZWzK4",
    "ipfs://QmPDzY6eoUwBHoXJ4ykZXX7x9sbEkdts3s3mYqFrLUBAs5",
    "ipfs://QmZLhm2FFtDJB3Anxa9qwJsbMrYuzqnb7hQG5J6LBf5R55",
    "ipfs://QmSbTWHeAHLwdpFboaay2vDjQRDgfQxjASdZsKkHWRt6bB",
    "ipfs://Qmb1XobC1YMbCXoyBjgP23V4ZEi2dYdtcgAXq2Z3Y9qwXK",
    "ipfs://QmXVdz3Ay4PGEmdWdf7Nxjy648eB8Mu4842x1PFs9XtCsB",
    "ipfs://QmSKp48X49EV8TNybaLHEB5qXS2GV8ikgE5Stbi1uprhxV"];

  // MAGICAL EVENTS.
  event NewEpicNFTMinted(address sender, uint256 tokenId);

  // We need to pass the name of our NFTs token and it's symbol.
  constructor() ERC721 ("ZiNFT", "ZI") {
    console.log("This is my ZiNFT contract. Woah!");
  }

  function random(string memory input) internal pure returns (uint256) {
      return uint256(keccak256(abi.encodePacked(input)));
  }

  function pickRandom(uint256 tokenId) public view returns (string memory) {
    uint256 rand = random(string(abi.encodePacked("WoW", Strings.toString(tokenId))));
    rand = rand % jsonipfs.length;
    return jsonipfs[rand];
  }

  // A function our user will hit to get their NFT.
  function makeAnEpicNFT() public {

      // tokenID starts at 0, make it starts from 1
    _tokenIds.increment();

     // Get the current newItemId
    uint256 newItemId = _tokenIds.current();

     // Actually mint the NFT to the sender using msg.sender.
    _safeMint(msg.sender, newItemId);
    console.log("An NFT with ID %s has been minted by %s", newItemId, msg.sender);

    string memory tokenURI = pickRandom(newItemId);

    // Set the NFTs data.
    _setTokenURI(newItemId, tokenURI);

    emit NewEpicNFTMinted(msg.sender, newItemId);


  }
}