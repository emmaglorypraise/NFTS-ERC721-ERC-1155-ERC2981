// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/common/ERC2981.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract RetireCarbonCredits is ERC721, ERC721Enumerable, ERC2981, ERC721URIStorage, Pausable, Ownable, ERC721Burnable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    uint96 public royaltypercentage;
    address public royaltyaddress;
    string private url;

    struct ProjectData {
        string name;
        uint256 projectTokenId;
        string methodology;
        string region;
        string emissionType;
        string uri;
        address creator;
    }

    struct RetireData{
      uint256 retireTokenId;
      address beneceficiary;
      string retireMessage;
      uint256 timeStamp;
      uint256 amount;
    }

    mapping (uint256 => ProjectData) private _projectData;
    mapping (uint256 => RetireData) private _retireData;

   constructor() ERC721("Retire Carbon Credits", "RCC") { 
    royaltypercentage = 150; 
    royaltyaddress = 0xE3506A38C80D8bA1ef219ADF55E31E18FB88EbF4; 
    _setDefaultRoyalty(royaltyaddress ,royaltypercentage ); 
    }

     function _baseURI() internal view override returns (string memory) {
        return url;
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function safeMint(address to, string memory uri, string memory _name, string memory _methodology, string memory _region, string memory _emissionType) public whenNotPaused onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);

        _projectData[tokenId] = ProjectData({
          projectTokenId : tokenId,
          uri : uri,
          name : _name,
          methodology : _methodology,
          region : _region,
          emissionType : _emissionType,
          creator : msg.sender
        });
      
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
        internal
        whenNotPaused
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function burnToken(uint256 tokenID, string memory _retireMessage, uint256 _amount) public whenNotPaused {
      address owner = ownerOf(tokenID);
      require(owner == msg.sender, "Only owner can burn this NFT");
      _burn(tokenID);
      _retireData[tokenID] = RetireData({
        retireTokenId : tokenID,
        beneceficiary : msg.sender,
        retireMessage : _retireMessage,
        timeStamp : block.timestamp,
        amount : _amount

      });
    }

    function ownerOf(uint256 tokenId) public view virtual override (ERC721, IERC721) returns(address){
      address owner = _ownerOf(tokenId);
      require(owner != address(0), "ERC721 cannot be zero");
      return owner;
    }
    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC2981, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function getProjectDate(uint256 tokenId) public view returns (ProjectData memory){
      return _projectData[tokenId];
    }

    function getRetireData(uint256 tokenId) public view returns (RetireData memory) {
      return _retireData[tokenId];
    }
}