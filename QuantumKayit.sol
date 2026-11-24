// Kaynak: Quantum Blokzincir Takimi - QuantumKayit
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title Quantum Blokzincir Takımı · Üye Kayıt Sözleşmesi
/// @notice Her cüzdan ismini bir kez zincire yazar. İsim içeriği denetlenmez;
///         hangi isimlerin gösterileceğine takım sitesi karar verir.
contract QuantumKayit {
    struct Kayit {
        address uye;
        string isim;
        uint256 sira;
        uint256 zaman;
    }

    Kayit[] private kayitlar;
    mapping(address => bool) public kayitliMi;

    event Registered(address indexed uye, string isim, uint256 sira, uint256 zaman);

    /// @notice İsmini kaydet. Aynı cüzdanla ikinci deneme revert verir.
    function register(string calldata name) external {
        require(!kayitliMi[msg.sender], "Bu cuzdan zaten kayitli");

        kayitliMi[msg.sender] = true;
        uint256 sira = kayitlar.length + 1;
        kayitlar.push(Kayit(msg.sender, name, sira, block.timestamp));

        emit Registered(msg.sender, name, sira, block.timestamp);
    }

    /// @notice Tüm kayıtlar, kayıt sırasıyla.
    function tumKayitlar() external view returns (Kayit[] memory) {
        return kayitlar;
    }

    function kayitSayisi() external view returns (uint256) {
        return kayitlar.length;
    }
}
