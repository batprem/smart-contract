// pragma solidity >=0.7.0 <0.9.0;

// import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

// contract SimpleCollectible is ERC721 {
//     uint256 public tokenCounter;

//     constructor() public ERC721("test-prem", "Naja") {
//         tokenCounter = 1;
//     }

//     function createCollectible(string memory tokenURI)
//         public
//         returns (uint256)
//     {
//         uint256 newItemId = tokenCounter;
//         _mint(msg.sender, newItemId);
//         _setTokenURI(newItemId, tokenURI);

//         tokenCounter = tokenCounter + 1;

//         return newItemId;
//     }
// }
