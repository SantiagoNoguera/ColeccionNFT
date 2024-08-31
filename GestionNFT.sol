// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ColeccionNFT is ERC721URIStorage, Ownable {
    uint256 private _contadorToken;

    mapping(address => uint[]) private _tokenDeUsuario;

    constructor(string memory nombreColeccion, string memory simboloColeccion)
        ERC721(nombreColeccion, simboloColeccion)
        Ownable(msg.sender)
    {
        _contadorToken = 0;
    }

    function crearNFT(address destinatario, string memory uri) public virtual onlyOwner returns (uint) {
        uint nuevoTokenID = _contadorToken;
        _mint(destinatario, nuevoTokenID);
        _setTokenURI(nuevoTokenID, uri);
        _tokenDeUsuario[destinatario].push(nuevoTokenID);
        _contadorToken++;
        return nuevoTokenID;
    }

    function getNFTUsuario(address usuario) public view returns (uint[] memory) {
        return _tokenDeUsuario[usuario];
    }

}
