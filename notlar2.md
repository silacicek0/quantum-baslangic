## İP 11: Çalışma Ortamını Hazırla
 
### Remix IDE ve Solidity
* **Remix IDE:** Tarayıcı üzerinde, kurulum gerektirmeden akıllı sözleşme yazmayı, derlemeyi ve test ağına yüklemeyi (deploy) sağlayan geliştirme ortamıdır.
* **Solidity:** Ethereum gibi EVM tabanlı ağlarda çalışan akıllı sözleşmeleri yazmak için kullanılan programlama dilidir.

### Benim Yorumum
Bu çalışmada bana en yeni gelen araçlar **MetaMask** ve **Remix IDE** oldu, ikisini de ilk defa inceledim. MetaMask'te cüzdan oluşturup kurtarma ifadesinin (12 kelime) neden bu kadar önemli olduğunu ve kimseyle paylaşılmaması gerektiğini uygulamalı olarak gördüm. Remix IDE'de ise Solidity dosyası oluşturabildiğim çalışma alanını tanıdım.

Kurulumda adım adım ilerledim: önce Git ve GitHub tarafını hazırladım, sonra MetaMask'i resmî siteden kurup cüzdanımı oluşturdum, en son Remix IDE'yi tarayıcıda açtım.  

 
---

## İP 12 — Kriptografik Cüzdan Türetme (Entropi, Mnemonic, Seed ve HD Anahtarlar)

### Entropi, Mnemonic ve Seed Akışı
* **Entropi:** İşlemci zamanlamalarındaki milisaniyelik sapmalar, donanım kesmeleri ve fare/klavye zamanlamaları gibi öngörülemez kaynaklar işletim sisteminin entropi havuzunda toplanır. `crypto.getRandomValues(new Uint8Array(16))` çağrısı bu kriptografik havuzdan **16 byte (128 bit)** veri çeker. `Math.random()` deterministik bir sözde-rastgele (PRNG) üreteçtir ve tohumu yakalanırsa tahmin edilebilir; `crypto.getRandomValues` ise kriptografik olarak güvenli rastgelelik sağlar.
* **Mnemonic (12 Kelime):** 128 bitlik entropinin SHA-256 özetinin ilk **4 biti** sonuna *checksum* (sağlama) olarak eklenerek **132 bit** elde edilir. Bu yapı **11'er bitlik 12 parçaya** ($12 \times 11 = 132$) bölünür ve her 11 bitlik değer (`0–2047`), BIP39 İngilizce kelime listesindeki bir kelimeye karşılık gelir. Entropide 1 bitlik değişim en az bir kelimeyi değiştirir; rastgele seçilen kelimelerde checksum tutmazsa ifade geçersiz sayılır.
* **Seed:** 12 kelimelik ifade ve (bu çalışmada boş `""` olan) *passphrase*, **PBKDF2** (`HMAC-SHA512`, 2048 iterasyon) fonksiyonundan geçirilerek **512 bit (64 byte)** uzunluğunda ana tohum (*seed*) üretir. Kelime sırası veya içeriği değiştiğinde tamamen farklı bir seed oluşur.

> **Kısa Özet:** **Entropi** tek rastgele girdidir (128 bit). **Mnemonic**, bu 128 bit ile 4 bit sağlamanın kelime karşılığıdır. **Seed**, kelimelerden türetilen 512 bitlik ana tohumdur.

### HD Türetme Yolu (`m/44'/60'/0'/0/0`) ve Anahtarlar
* **HD Yol (`BIP32 / BIP44`):** `m/44'/60'/0'/0/0` yolu üzerinden seed'den hiyerarşik alt anahtarlara inilir (`60'` Ethereum coin tipini, sondaki `0/0/0` ise ilk hesap / harici zincir / ilk indeksi ifade eder).
* **Private Key:** İlgili yoldan elde edilen **256 bitlik (64 hex karakter)** gizli anahtardır.
* **Public Key:** Private key üzerinden `secp256k1` eliptik eğrisi ile türetilen açık anahtardır.
* **Ethereum Adresi (`0x...`):** Public key'in Keccak-256 özetinin son **20 byte'ı**dır (40 hex karakter, `0x` önekiyle).

### Hassas Alanların Gizlenmesi
Yeni cüzdan oluşturulduğunda **Entropi**, **12 Kelime**, **Seed** ve **Private Key** varsayılan olarak `••••••••` şeklinde gizli tutulur ve *"Göster / Gizle"* butonuyla açılır. **Public Key** ve **Ethereum Adresi** ise açık bilgi olduğu için doğrudan görünür kalır.

### Mnemonic ile Private Key Arasındaki Fark
* **Mnemonic**, seed üzerinden tüm HD cüzdan ağacının (`m/44'/60'/0'/0/1`, `m/44'/60'/0'/0/2` vb. farklı indekslerdeki hesapların da) yeniden türetilmesini sağlayan ana kurtarma yedeğidir.
* **Private Key**, yalnızca türetildiği tek bir yoldaki (`m/44'/60'/0'/0/0`) hesabın işlemlerini imzalamaya yarar; ondan geriye dönerek 12 kelime veya diğer alt hesaplar elde edilmez.
* Uygulamada her iki alan da varsayılan olarak gizli (`••••••••`) tutulmuştur.

---

## İP 13 — Geçerli Mnemonic ile Güvenli Üretilmiş Mnemonic Farkı

**Hayır, aynı iddia değildir.**
* **Geçerli (valid) mnemonic**, yalnızca BIP39 kelime listesinde bulunan ve sonundaki *checksum* bitleri doğrulanan 12 kelimelik dizidir. Zayıf veya tahmin edilebilir bir kaynakla üretilmiş ya da elle kurcalanmış bir ifade doğrulamadan geçse bile güvenli sayılmaz.
* **Güvenli biçimde üretilmiş mnemonic**, başlangıçtaki 128 bit entropinin kriptografik olarak güvenli bir kaynaktan öngörülemez şekilde üretilmiş olmasını ifade eder.

---

## İP 14 — Açık Adres Paylaşmanın Harcama Yetkisi Vermemesi

Ethereum adresi (`0x...`), tıpkı bir IBAN veya e-posta adresi gibi varlık alımı için paylaşılan açık hedeftir. Bakiye harcamak veya varlık göndermek için kriptografik imza gerekir ve bu imza yalnızca **private key** (veya onu türeten **mnemonic**) ile üretilebilir. Açık adresi bilen biri o hesaba gönderim yapabilir ancak private key'e sahip değilse varlıkları harcayamaz.

---

## İP 15 — Sepolia ETH Transferi ve ERC-20 (USDC) Transferi

| Alan / Kavram | Sepolia ETH Transferi | USDC (ERC-20) Transferi |
| :--- | :--- | :--- |
| **To** | Doğrudan alıcı cüzdan adresi | USDC akıllı sözleşmesinin adresi |
| **Value** | Gönderilen ETH miktarı | Genellikle `0 ETH` (aktarım sözleşme defterinde yapılır) |
| **Input Data** | Çoğunlukla boş (`0x`) | `transfer(address to, uint256 amount)` çağrısının kodlanmış verisi (`0xa9059cbb...`) |
| **İşlem Ücreti** | Sepolia ETH ile ödenir | Sepolia ETH ile ödenir |
| **Log / Kayıt** | Yerel bakiye değişimi | Sözleşmede `Transfer(from, to, value)` log'u ve Etherscan'de *ERC-20 Tokens Transferred* kaydı |

* **Cüzdanda Göstermek vs. Zincirde Almak:** Zincirde almak, işlem onaylandığında USDC sözleşmesindeki bakiye kaydının güncellenmesidir. Cüzdanda göstermek ise yalnızca arayüzün ilgili sözleşme bakiyesini ekranda listelemesidir; zincirdeki mülkiyeti değiştirmez.
* **Ücret Bakiyesi:** USDC gönderirken işlem ücreti USDC'den değil, gönderenin **Sepolia ETH** bakiyesinden karşılanır. Cüzdanda USDC bulunsa bile hiç Sepolia ETH yoksa transfer işlemi gönderilemez.

---

## İP 16 — Arayüzde Görünme ile Zincirde Kayıtlı Olma Farkı

**Hayır, aynı kontrol değildir.** Zincirdeki kayıt, işlemin Sepolia ağında onaylanıp sözleşme durumuna işlendiğini gösterir; sitede görünmesi ise ön yüzün zincir verisini okuyup ekrana yansıtmasına bağlıdır.

---

## İP 17 — İşlem Yaşam Döngüsü ve Etherscan Detayları (`QuantumKayit`)

### İşlem Alanları
* **From:** İşlemi imzalayıp gönderen kendi cüzdan adresim.
* **To:** `register` fonksiyonunun çağrıldığı `QuantumKayit` sözleşme adresi.
* **Gas Used / Ücret:** İşlem yürütülürken harcanan gas birimi ve karşılığında ödenen Sepolia ETH tutarı.
* **Nonce:** Gönderen hesaptan çıkan işlemlerin sıra numarası (*More Details* altında görünür).
* **Status (`Success`):** İşlemin Sepolia blokzincirinde başarılı onaylandığını gösterir.
* **Input Data:** `register("silacicek")` çağrısına ait verinin ABI kodlanmış hali (*More Details* -> *Decode Input Data* ile okunabilir).

### Uçtan Uca İşlem Akışı
```text
[1. Cüzdan Onayı / İmzalama]
   Hesap: 0x06a5Bbd64f25c2bf2A7241411Cb21Ed68Df51F62 (Sepolia)
   İşlem: register("silacicek") -> Sözleşme: 0x81Dd700C459BF2806A1B5F2a349c89f0106A9036
         │
         ▼
[2. Gönderim]
   Tx Hash: 0x6a5a24a0b4d443aa96562500b51ff90f06c9879fd493fac801ceaeab5ef3c27b
         │
         ▼
[3. Bekleme]
   İşlem ağa iletildi ve bloğa alınmayı bekledi
         │
         ▼
[4. Bloğa Alınma]
   Sepolia Block: #12203983 (Nonce: 1, Gas Used: 583,555)
         │
         ▼
[5. Sonuç Kontrolü]
   - Status: Success
   - Decode Input Data: name = "silacicek"
   - Logs: Registered event (uye: 0x06a5Bbd64f25c2bf2A7241411Cb21Ed68Df51F62, isim: "silacicek")
   - Read Contract: kayitliMi -> true, tumKayitlar -> "silacicek"
   - Kontrol Sitesi: "silacicek" görünür durumda
```

* **Gönderilmeyen Hata vs. Revert Olan İşlem:** İkinci kayıt denemesinde Remix `estimateGas` aşamasında cüzdanın zaten kayıtlı olduğunu görüp uyardı (`"Bu cuzdan zaten kayitli"`) ve işlem ağa hiç gönderilmeden iptal edildi (`tx hash` veya makbuz oluşmadı). Bloğa girip `revert` olan işlemde ise zincire çıkmış ve makbuz/hash üretilmiş bir işlem söz konusudur.
* **Input Data, Event ve State:** *Input Data* hangi girdinin gönderildiğini, *Event (`Registered`)* loglara hangi verilerle düşüldüğünü, *mevcut state (`kayitliMi`, `tumKayitlar`)* ise işlem sonunda sözleşmede kalıcı olarak neyin tutulduğunu gösterir.

---

## İP 18 — Farklı Adreste Çalışan Kodun Eski Kayıtları Taşımaması

Her `deploy` işlemi yeni bir sözleşme adresi ve kendi bağımsız depolama alanını (`storage` / `state`) oluşturur. Takım sözleşmesindeki kayıtlar o sözleşmenin adresinde kalır; aynı kodla açılan yeni kopya ise sıfırdan ve boş bir durumla başlar.

---

## İP 19 — Arayüz Rolü ve Bağımsız Sözleşme Örneği

* **Remix ve Etherscan:** Sözleşmenin kendisi değil, ABI üzerinden çağrı paketleyen ve Sepolia RPC ile ağa bağlanan istemci/arayüz araçlarıdır. Sözleşme kodu ve verileri Sepolia zincirinde tutulur; okuma (`Call`) doğrudan zincirden veri çeker, yazma (`Transact`) ise imzalı işlem üretir.
* **Takım Sözleşmesi vs. Kendi Kopyam:** Aynı cüzdan takım sözleşmesine ikinci kez kaydolamazken kendi kopyama kaydolabilmesinin nedeni iki sözleşmenin farklı adreslerde ve bağımsız kayıt listelerine sahip olmasıdır.

---

## İP 20 — İlk Takma Ad Sözleşmesi: Depolama, `msg.sender` ve Eksikler

* **Veri Tutumu:** Veriler sözleşmenin kalıcı `storage` alanında `mapping(address => string) public takmaAdlar` yapısında (adres -> takma ad) saklanır.
* **`msg.sender`:** Fonksiyon çağrısını/işlemi gönderen cüzdan adresidir. `takmaAdlar[msg.sender] = _takmaAd;` sayesinde kayıt başkası adına değil, işlemi gönderen kendi adresine yazılır.
* **İlk Sürümdeki Kısıt Eksiklikleri:**
  * Aynı adres `takmaAdKaydet` çağırınca eski takma adın üzerine yenisi yazılır.
  * Boş metin (`""`) kontrolü bulunmadığından boş takma ad kaydedilebilir.
  * Takma ad benzersizliği kontrol edilmez; farklı adresler aynı takma adı alabilir.
  * Uzunluk veya karakter sınırı yoktur.

---

## İP 21 — Kayıt ve Kapasite Kurallarının Testi

1. **İlk geçerli kayıt (`Account 1` -> `isim_bir`):** Kabul edildi; `toplamKayit` = `1`.
2. **Aynı hesaptan tekrar kayıt (`Account 1` -> `isim_iki`):** Revert ile reddedildi (`"Bu adres zaten kayitli"`); `toplamKayit` = `1`.
3. **Yeni hesaptan boş ad (`Account 2` -> `""`):** Revert ile reddedildi (`"Takma ad bos olamaz"`); `toplamKayit` = `1`.
4. **İkinci ve üçüncü geçerli kayıt (`Account 2` -> `isim_iki`, `Account 3` -> `isim_uc`):** Her ikisi de kabul edildi; `toplamKayit` = `3`.
5. **Dördüncü farklı hesabın kaydı (`Account 4`):** Kapasite dolduğu için revert ile reddedildi (`"Kapasite dolu"`); `toplamKayit` = `3`.

* **Adres Başına Sınır Neden Gerçek Kişi Sayısını Garanti Etmez?** Cüzdan açmak ücretsiz ve kimlik doğrulamasız olduğu için tek kişi birden fazla adresle kontenjanı doldurabilir; tersine ortak veya kurumsal/bot bir adres birden fazla kişiye karşılık gelebilir. Adres sınırı adres sayısını sınırlar, kimlik doğrulaması olmadan gerçek kişi sayısını garanti etmez.

---

## İP 22 — `EtkinlikKayit3`: Görevli Yetkisi ve Giriş Onayı Testleri

* **Ön Koşul:** `Account 1` sözleşmeyi *deploy* ederek `gorevli` oldu; `Account 2` `takmaAdKaydet` ile kaydoldu ve `KatilimciKaydoldu` event'i oluştu.
* **1. Görevli kayıtlı kişiye giriş verir (`Account 1` -> `Account 2`):** İşlem onaylandı, `GirisYapildi` event'i oluştu ve `girisYaptiMi[Account 2]` `true` döndü.
* **2. Görevli olmayan hesap giriş verir (`Account 2` / `Account 3`):** Revert ile reddedildi (`"Sadece gorevli islem yapabilir"`), durum değişmedi.
* **3. Görevli kayıtsız adrese giriş verir (`Account 1` -> `Account 4`):** Revert ile reddedildi (`"Bu adres kayitli degil"`), `girisYaptiMi[Account 4]` `false` kaldı.
* **4. Aynı katılımcıya ikinci giriş (`Account 1` -> `Account 2` tekrar):** Revert ile reddedildi (`"Bu katilimci zaten giris yapti"`), ilk `true` kaydı korundu.

* **Yetkiyi Arayüzde Gizlemek Yerine Sözleşmede Denetlemek:** Buton gizlemek yalnızca görsel bir engellemedir; sözleşme zincirde açık olduğu için doğrudan sözleşmeye çağrı yapılabilir. Yetki kuralı (`onlyGorevli`) sözleşme içinde zorunlu kılınmalıdır.

---

## İP 23 — Sepolia'ya Deploy ve Ortam Ayrımı

* **Deploy Bilgileri:** `EtkinlikKayit3` sözleşmesi Sepolia Testnet üzerinde `Account 1` (`0x06a5Bbd64f25c2bf2A7241411Cb21Ed68Df51F62`) ile deploy edildi (`gorevli` atandı).
  * **Sözleşme Adresi:** `0xfc4dad9c2f2d024dd9a756fbab9ebc4a7ad3b66b`
  * **Deploy Tx Hash:** `0x2e2cf9ca0c823a2f4de6efae25f82b87da94913f80aa9955321f1840140afc70`
  * **Derleme Ayarları:** Solidity `0.8.34`, optimizer açık (`runs=200`).
  * **ABI ve Anahtarlar:** JSON ABI notlara eklendi; private key paylaşılmadı/eklenmedi.
* **Sepolia İşlemleri:** Sepolia ETH temin edildikten sonra `takmaAdKaydet` ve görevli üzerinden `girisVer` çağrıları onaylandı; `takmaAdlar` ve `girisYaptiMi` (`true`) değerleri doğrulandı.
* **Yerel VM vs. Sepolia:** Sepolia explorer'da işlemler görünürken, önceki yerel Remix VM denemesindeki adres için Sepolia sözleşmesinde `takmaAdlar` boş (`""`) döndü; yerel kayıtlar yeni Sepolia sözleşmesine taşınmaz.
* **Sürümleri Karıştırmamak İçin Kontroller:** Ağ/ortam (Remix VM vs. Sepolia), sözleşme adresi ve deploy işlem hash'i (`tx hash`) birlikte kontrol edilmelidir.

---

## İP 24 — `EtkinlikKayit3` İçin Web Arayüzü (dApp) Geliştirme

### Açıklama
Sepolia test ağındaki `EtkinlikKayit3` (`0xfc4dad9c2f2d024dd9a756fbab9ebc4a7ad3b66b`) akıllı sözleşmesiyle konuşan `index.html`, `config.js` ve `app.js` dosyalarından oluşan bir web arayüzü kuruldu. Ethers.js v6 (`BrowserProvider`, `Contract`, `Signer`) üzerinden sözleşmenin `etkinlikAdi`, `KAPASITE`, `toplamKayit` ve `gorevli` verileri ile bağlı hesaba göre `takmaAdlar`, `kayitliMi` ve `girisYaptiMi` durumları okundu; `takmaAdKaydet` ve `girisVer` yazma fonksiyonları arayüzdeki butonlara bağlandı. İlk okumada `webinar` etkinliği, `3` kapasite, `0x06a5Bbd64f25c2bf2A7241411Cb21Ed68Df51F62` görevli adresi ve güncel kayıt sayıları ekrana geldi.

### Benim Yorumum
Okuma ve yazma katmanını net ayırmak bu işin temel taşıydı: veri okuma imzasız çalışırken, durum değiştiren işlemlerde Sepolia ağı ve `Signer` doğrulaması şart. `app.js` içindeki sözdizimi hatalarının tüm modülü kilitlemesi `Console` takibinin ne kadar kritik olduğunu gösterdi; sözleşme kurallarını sadece arayüzde gizlemek yerine gerçek zincir sonuçlarıyla yönetmek daha sağlıklı bir yapı kurdu.

---

## İP 25 — Arayüz Durum Yönetimi, Hata Yakalama ve Uçtan Uca Test

### Açıklama
Web arayüzü Sepolia üzerinde farklı hesap ve senaryolarla test edilip durum güncelleme ve hata mesajları doğrulandı. Zaten kayıtlı olan görevli hesap (`Account 1`, `0x06a5Bbd64f25c2bf2A7241411Cb21Ed68Df51F62`) ile ikinci kez kayıt denendiğinde sözleşme geri çevirmesi yakalanarak kullanıcıya uyarı gösterildi; `Account 2` (`0xd7749D9fB78bf7cEc3A328de75EE60eeA98CfD5C`) ile `test_kisi` takma adı kullanılarak yapılan kayıt işleminde işlem hash'i, Etherscan bağlantısı ve onay sonrası `toplamKayit` (`2`) ile kullanıcı durumu güncellendi. Görevli olmayan hesaptan `girisVer` çağrıldığında yetki engeli yakalandı; görevli hesapla `0xd7749D9fB78bf7cEc3A328de75EE60eeA98CfD5C` için giriş onayı verildiğinde işlem blokta (`#12216826`) onaylandı ve ekran verileri yenilendi. Ayrıca hata yönetiminde kesin red/iptal durumları *"işlem başarısız"* olarak, ağ/RPC veya onay belirsizliği yaşayan durumlar ise *"sonuç henüz doğrulanamadı"* olarak ayrıldı.

### Benim Yorumum
Ham RPC/Ethers.js hatalarını olduğu gibi basmak yerine kullanıcıya anlaşılır karşılıklar üretmek arayüz kalitesini ciddi biçimde artırıyor. Özellikle *"işlem başarısız"* ile *"sonuç henüz doğrulanamadı"* ayrımının mantığını oturtmak çok önemliydi: imza reddi veya sözleşme `require` revert'ü kesin sonuçken, bağlantı/zaman aşımı veya `tx.hash` sonrası doğrulama kopukluğunda işlem arka planda onaylanmış olabileceği için kullanıcıyı yanlış yönlendirmemek ve otomatik tekrar göndermemek gerekiyor. `Bilgileri yenile` ve `accountsChanged` akışlarını da oturtunca ön yüz ile sözleşmenin birlikte nasıl çalıştığı iyice netleşti.