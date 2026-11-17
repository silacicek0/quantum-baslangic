# 📚 Blokzincir Araştırma Notları (QTeam)

## 1. Blokzincir ve Ortak Kayıt (İP 01)

* **Ethereum Sepolia:** Gerçek para harcamadan ve gerçek ana ağı tehlikeye atmadan önce akıllı sözleşmelerin, merkeziyetsiz uygulamaların ve protokol güncellemelerinin test edilmesini sağlayan test ağıdır.
* **Blokzincir:** Birbirine zincirleme halkalarla bağlı dijital bir veri defteridir. Verilerin güvenli, şeffaf ve değiştirilemez bir şekilde saklanmasını sağlayan dijital bir kayıt teknolojisidir.
* **İşlem (Transaction):** Sistemin en temel veri birimidir. Bir değerin veya verinin bir hesaptan diğerine aktarılmasını ifade eder *(Örn: Ahmet, Mehmet'e 1 BTC gönderdi)*.
* **Blok:** Belirli bir zaman diliminde gerçekleşen birden fazla işlemin bir araya getirilerek paketlendiği dijital yapılardır. Her blok kendisinden önceki bloğun benzersiz şifreleme kodunu taşır *(özet / hash)*.
* **Blockchain (Blokzincir):** Bu blokların kronolojik olarak birbirine şifreleme bağlarıyla eklenmesiyle oluşan zincirleme veri yapısıdır.
* **Dağıtık Defter (Distributed Ledger):** Bu veri zincirinin tek bir merkezde *(örneğin bir bankanın bilgisayarında)* değil, ağa bağlı binlerce farklı bilgisayarda *(düğüm / node)* aynı anda eş zamanlı olarak saklanması mimarisidir.

**İşlem Akışı ve Yapı İlişkisi:**
`Transactions (İşlemler)` → Bir araya gelip paketlenir → `[Blok]` → Kronolojik olarak dizilir → `[Blockchain]` → Herkese dağıtılır → `[Distributed Ledger]`
* İşlem, ağdaki hareketliliktir. Bunlar birikir → blok oluşur. Bloklar şifreleme yöntemiyle arka arkaya dizilerek **Blockchain**'i meydana getirir *(verinin nasıl organize edildiğini / zincir yapıyı tanımlar)*.
* Oluşan blockchainler, ağdaki tüm bilgisayarlara kopyalanarak **Distributed Ledger** üzerinde güncellenir *(verinin nasıl saklandığını ve paylaşıldığını ifade eder)*.

### Merkezi Veritabanı vs. Blockchain
* **Merkezi Veritabanı:** Kontrol tamamen tek bir kurum veya yöneticidedir. **CRUD** *(Create, Read, Update, Delete)* yetkileri merkeze aittir. Yönetici dilerse geçmişe dönük verileri değiştirebilir veya silebilir.
* **Blockchain:** Kontrol dağıtık bir ağa *(konsensüs mekanizmasına)* aittir. Veriler sadece eklenebilir (**Append-only**); geçmişe dönük bir veriyi silmek veya değiştirmek ağdaki düğümlerin *(node)* çoğunluğunun onayı olmadan imkânsızdır.
* **Güven Farkı:**
  * Merkezi veritabanında güven üçüncü bir tarafa *(banka, şirket vb.)* dayanır. Kullanıcılar verinin doğruluğu için bu merkeze inanmak zorundadır.
  * Blockchain'de güven matematiksel şifreleme ve protokollere *(Trustless / Güven gerektirmeyen sistem)* dayanır. Kimsenin birbirine inanmasına gerek yoktur; sistem şifreleme algoritmalarıyla kendi doğruluğunu sağlar.
* **Hata Toleransı ve Saldırı Riski:**
  * Merkezi veritabanında tek bir başarısızlık noktası (**Single Point of Failure**) vardır. Saldırganlar merkezi sunucuyu ele geçirdikleri zaman tüm sistemi çökertebilir veya verileri değiştirebilir.
  * Blockchain'de değişim maliyeti yüksektir. Veriler binlerce bilgisayarda aynı anda tutulur. Sistemi manipüle etmek için ağın bilgi işlem gücünün en az %51'ini *(51% Saldırısı)* ele geçirmek gerekir ki bu büyük ağlarda mali açıdan neredeyse imkânsızdır.

| Özellik | Merkezi Veritabanı | Blockchain |
| :--- | :--- | :--- |
| **Veri Yönetimi** | Merkez (Otorite/Yönetici) | Dağıtık Ağ (Konsensüs) |
| **Değiştirilebilirlik** | Veriler silinebilir, değiştirilebilir | Veriler kalıcıdır, geriye dönük değiştirilemez |
| **Siber Direnç** | Güvenlik duvarları ve merkezi şifreleme | Kriptografik bantlar (hash) ve dağıtık yapı |
| **Şeffaflık** | Dışarıya kapalı veya sınırlı erişim | Herkes tarafından denetlenebilir ve açık |
| **Hata Toleransı** | Sunucu çökerse sistem durur | Birkaç düğüm çökse bile ağ çalışmaya devam eder |

### Geçmiş İşlem Kaydı vs. Güncel Durum (State)
* **Geçmiş İşlem Kaydı (Transaction / Log):** Geçmişte yapılan her işlem, blokzincir defterine kalıcı olarak yazılır. Bir akıllı sözleşmeye gönderilen her talep *(örneğin: Ahmet, sözleşmedeki X değerini 5 yap)* bir transaction olarak bir bloğun içine gömülür ve kriptografik olarak kilitlenir. Bu işlem kaydı asla değiştirilemez ve silinemez. Bir şirketin muhasebe defterindeki satırlar gibidir; karalanıp silinemez, sadece altına yeni satır eklenir.
* **Sözleşmede Tutulan Güncel Değer (State / Durum Verisi):** Sözleşmenin o anki hafızasında sakladığı ve uygulamaların sorguladığı en son değerdir. Akıllı sözleşmenin içinde tanımlanmış değişkenlerdir. Bu veriler blokzincirin **World State** adı verilen güncel veri tabanında saklanır. Sözleşmenin kuralları dahilinde bu değer güncellenebilir *(örneğin: Ahmet'in banka hesabındaki 10 olan toplam bakiye bilgisi)*.
* **İlişki:** Geçmiş işlem kaydı → blokların içinde depolanır; Güncel durum verisi → durum ağacında depolanır. Bir tetikleyici sayesinde *(Transaction)* → Güncel durum verisi güncellenir.

### Etkinlik Kayıt Sisteminde Blockchain Kullanımı
* **Avantajlar:**
  1. Bilet sahteciliğinin ve karaborsanın önlenmesinde önemli avantajlar sağlar.
  2. Her bilet benzersiz bir dijital varlık *(NFT veya akıllı sözleşme kaydı)* olarak basılır.
  3. Sunucular çökse bile etkinlik verilerine erişilebilir.
  4. Akıllı sözleşmelerle *"ikinci el satış fiyatı"* gibi kurallar kodlanabilir. Bu bilet el değiştirdiğinde sürekli biletin belirlenen fiyattan daha pahalıya satılması teknik olarak engellenebilir.
  5. Organizatörün bilet satıp sızdırmadığı, toplam bilet sayısı ve sponsorlara ayrılan kontenjanlar net bir şekilde denetlenebilir.
* **Dezavantajlar:**
  1. Ağ ücretleri (**Gas Fee**): Blokzincire yazılan her işlem için ağdaki madencilere bir ücret ödenir.
  2. Blokzincir ağları saniyedeki işlem limiti (**TPS**) nedeniyle kilitlenebilir ve kullanıcılar bilet almak için dakikalarca bekleyebilir.

| Kriter | Geleneksel Merkezi Sistem | Blockchain Tabanlı Sistem |
| :--- | :--- | :--- |
| **İşlem Hızı** | Çok yüksek (saniyede on binlerce bilet) | Düşük / Orta (Ağ trafiğine bağlı) |
| **İşlem Başına Maliyet** | Çok düşük | Değişken |
| **Karaborsa Koruması** | Sınırlı | Tam koruma (akıllı sözleşme kurallarıyla) |
| **Güvenlik / Süreklilik** | Veritabanı hacklenirse biletler çalınabilir | Kriptografik koruma, hacklenmesi neredeyse imkânsız |

* **Yorum - Hangi Durumda Normal Veritabanı Tercih Edilir?**
  * Taraflar birbirine güveniyor veya ortada yasal bir düzenleme varsa blokzincir gereksiz bir maliyet ve iş yüküdür.
  * Örneğin: Canlı bilet satışları, anlık mesajlaşma uygulamaları, dijital banka ekstreleri veya e-ticaret sitelerinin sepet işlemlerinde **merkezi veritabanı** tercih edilir. Çünkü kullanıcı profil bilgileri sürekli güncellenir, kişisel medya bilgileri yayılır *(gizlilik esastır)* ve kişisel verilerin silinme hakkı *(KVKK vb.)* vardır; bu sistemler hız gerektirir.

---

## 2. Node ve Konsensüs (İP 02)

* **Node (Düğüm):** Blockchain ağına bağlı olan, ağdaki yazılımı çalıştıran ve defterin tam veya kısmi bir kopyasını tutan her türlü bilgisayar veya cihazdır. Ağdaki işlemleri kontrol eder, kurallara uygunluğunu doğrular; bu işlemleri diğer node'lara iletir ve verileri depolar.
* **Validator (Doğrulayıcı):** Blokzincirde gerçekleşen işlemlerin kurallara uygunluğunu denetleyen, onaylayan ve blokları zincire ekleyerek ağın güvenliğini sağlayan yetkili node türleridir.
* *Not:* **Her node blok üretmez.** Sadece **Validator** *(PoS sistemlerde)* veya **Madenci** *(PoW sistemlerde)* blok üretir.
* **Konsensüs (Mutabakat):** Mekanizmaları, merkezi bir otoriteye *(örneğin: banka)* ihtiyaç duymadan tüm katılımcıların tek bir doğru üzerinde anlaşmasını sağlar. Aynı dijital varlığın iki kez harcanmasını engeller.
  * Birbirini tanımayan veya güvenmeyen tarafların ortak bir veri defterine güvenmesini sağlar.
  * Ağdaki kötü niyetli aktörlerin geçersiz verileri değiştirmesini veya sahte işlemler eklemesini finansal ve teknik bariyerlerle zorlaştırır.

### PoW vs. PoS Yaklaşımları
* **Proof-of-Work (PoW - İş Kanıtı):** Ağlarında ise bu rolü madenciler üstlenir. Karmaşık matematiksel hesapları çözerek *(mining)* blok üretmeye çalışırlar.
  * **Örn (Bitcoin):** Dünyanın herhangi bir yerinde kurulu olan devasa Bitcoin madencilik çiftlikleri bulunur. Bu cihazlar her 10 dakikada bir, Bitcoin ağındaki yeni transferleri onaylayıp zincire eklemek için milyarlarca rastgele sayı tahmin üreterek şifreli bir matematik bulmacasını çözmeye çalışır. Bulmacayı ilk çözen yeni bloğun haklarını kazanır *(blok ödülü)* ve devasa elektrik tüketimi gerçekleşir.
* **Proof-of-Stake (PoS - Hisse Kanıtı):** Ağlarında, ağa kilitledikleri *(stake ettikleri)* varlık miktarına ve kurallarına göre işlem doğrulama ve blok ekleme hakkı kazanırlar.
  * **Örn (Ethereum):** Ethereum ağına gidip 32 ETH varlığını akıllı sözleşmeye kilitlersiniz *(stake edersiniz)*. Çevrimiçi çalıştırdığınızda ağın güvenliğine girmiş olursunuz. Ağın algoritması sistemde ETH kilitlemiş olan validator'lar arasından tamamen rastgele birini seçer. Validator zarar vermediği sürece kilitlediği paradan düzenli olarak faiz benzeri bir ETH geliri elde eder. Herhangi bir ağır PC kadar bile elektrik harcamaz.

| Özellik | Proof of Work (PoW) | Proof of Stake (PoS) |
| :--- | :--- | :--- |
| **Temel Kaynak** | Hesaplama Gücü (Donanım / Elektrik) | Kripto Varlık (Sermaye / Stake) |
| **Blok Üreticisi** | Miners (Madenciler) | Validators (Doğrulayıcılar) |
| **Seçim Kritiği** | Matematiksel bulmacayı ilk çözen kazanır | Kilitlenen (stake edilen) varlık miktarına göre seçilir |
| **Enerji Tüketimi** | Çok yüksek | Çok düşük (çevre dostu) |
| **Örnek Ağlar** | Bitcoin, Litecoin | Ethereum, Solana, Cardano |

### Ağ Türleri ve İzin Mekanizmaları
* **Public / Private:** Ağa verilerine erişim ve okuma izniyle ilgili.
* **Permissionless / Permissioned:** Ağa katılım, işlem gönderme ve doğrulayıcı olma yetkisiyle ilgilidir.

| Ağ Türü | Okuma İzni | İşlem Gönderme İzni | Doğrulayıcı Olma İzni | Açıklama ve Örnekler |
| :--- | :--- | :--- | :--- | :--- |
| **Public & Permissionless (1)** | Herkese Açık | Herkese Açık | Şartları sağlayan herkese açık | En yaygın, tamamen merkeziyetsiz türdür. Herkes her şeyi yapabilir. *(Örn: Bitcoin, Ethereum, Solana)* |
| **Public & Permissioned (2)** | Herkese Açık | Genellikle herkese açık | Sadece yetkilendirilmiş node'lar | Verilerin şeffaf olduğu ancak ağı sadece yetkili kişilerin yönettiği yapıdır. *(Örn: Dijital kimlik veya tapu sistemleri)* |
| **Private & Permissioned (3)** | Sadece yetkililer | Sadece yetkililer | Sadece yetkilendirilmiş node'lar | Tamamen kapalı, merkezi veya yarı merkezi yapılardır. Şirket içi veya bankalar arası operasyonlarda kullanılır. *(Örn: Hyperledger Fabric, Corda)* |
| **Private & Permissionless** | - | - | - | Pratikte pek kullanılmaz. |

### İşlemin Bloğa Alınması, Başarılı Çalışması ve Kesinleşmesi
1. **İşlemin Bloğa Alınması (Inclusion / Mining):** İşleminizin havuzdan *(Mempool)* alınıp bir validator tarafından yeni üretilen bir bloğun içine yazılmasıdır. İşlemin zincire eklendiğini gösterir, hatasız çalıştığını veya o bloğun asla silinmeyeceğini garantilemez.
2. **Başarılı Çalışması (Execution Success / Status: Success):** Bloğa alınan işlemin, ağın kurallarına ve kodlarına göre hatasız hedefine ulaşmasıdır. Bloğa alınmak başarılı çalışmayı garanti etmez.
3. **Kesinleşmesi (Finality):** Bir işlemin içinde bulunduğu bloğun, blokzincirin geçmişinden geriye dönük olarak değiştirilemez, silinemez ve iptal edilemez hale gelmesidir.
   * **PoW:** Finality olasılıksaldır; işlemin olduğu bloğun üzerine yeni bloklar eklendikçe işlem finalized kabul edilir.
   * **PoS:** Belirli sayıda validator bloğu onayladıktan sonra blok finalized olur ve matematiksel olarak ağ yok olmadıkça değiştirilemez.

* **Yorum - Tek Bir Node Kapanınca Bütün Ağın Durup Durmayacağı Neye Bağlıdır?**
  1. **Ağın Türü (Merkeziyet Derecesi):** Centralized *(merkezi)* ise *(tek 1 ana sunucu)* → o node kapanınca tüm ağ çöker. Decentralized ise hiçbir şey olmaz.
  2. **Konsensüs Mekanizmasının Hata Toleransı:**
     * **PoW:** Ağdaki madencilerin %90'ı kapansa bile ağ durmaz, sadece yeni blok üretme hızı yavaşlar.
     * **PoS / BFT:** Doğrulayıcıların en az %66.6'sının aktif *(Bizans Hata Toleransı)* ve çevrimiçi olması gerekir.
  3. **Node'un Ağdaki Görevi:** Sıradan bir node ise bir şey olmaz *(Full Node gibi)*; değilse ağ geçici olarak kilitlenebilir *(Lider Node / Master Node gibi)*.

---

## 3. Kriptografi ve Cüzdan (İP 03)

* **Hash Alma (Özetleme):**
  * **Temel Amacı:** Verinin bütünlüğünü doğrulamak ve benzersiz bir dijital parmak izi oluşturmaktır.
  * Herhangi bir uzunluktaki veriyi *(örneğin dosya, parola)* alır ve tek yönlü bir algoritmayla sabit uzunlukta *(örneğin SHA-256 ile 256 bitlik)* benzersiz bir özete dönüştürür.
  * Geriye döndürülemez, orijinal veriye bu özetten ulaşmak imkânsızdır.
  * **Kullanım Alanları:**
    1. Şifrelerin veritabanlarında şifrenin kendisi değil, hash özetinin saklanması.
    2. İndirilen bir yazılımın veya dosyanın yolda bozulup bozulmadığını aynı özetle eşleştirerek doğrulanması.
    3. Block chain'de blokları birbirine bağlarken ve veri bütünlüğünü korumada.
* **Encryption (Şifreleme):**
  * **Temel Amacı:** Veriyi yetkisiz kişilerden gizlemek ve gizliliği sağlamaktır.
  * Okunabilir durumdaki bir veriyi bir anahtar yardımıyla anlamsız hale getirir *(şifreli metin)*.
  * **Çift Yönlüdür:** Uygun anahtara sahip yetkili kişi şifreyi çözerek orijinal veriye tekrar ulaşabilir.
  * **Kullanım Alanları:**
    1. İnternette gönderilen kredi kartı bilgisi veya mesajların yolda okunmasını önlemek.
    2. Disk Şifreleme: Bilgisayar veya telefonun çalınması durumunda içindeki dosyaların okunmasını engellemek.
* **Digital Signature (Dijital İmza):**
  * **Temel Amacı:** Bir belgenin veya verinin kimden geldiğini *(aidiyet)* ve içeriğinin değişmediğini *(bütünlük)* ispat etmektir.
  * Gönderilecek belgenin önce bir hash değeri alınır. Bu özet gönderenin özel anahtarı *(private key)* ile şifrelenerek dijital imza üretilir. Alıcı, göndericinin açık anahtarı *(public key)* ile imzayı çözer ve kendi hesapladığı hash ile karşılaştırır.
  * **Kullanım Alanları:**
    1. Elektronik belge ve sözleşmeler *(e-imza)*; resmi sözleşme veya evraklara ıslak imza gibi hukuki olarak doğrulanması.
    2. Yazılım güncellemeleri: Bilgisayara giden bir güncellemenin gerçekten yazılım şirketinden geldiğini doğrular.

### Seed, Mnemonic, Key ve Adres İlişkisi
* **Seed (Anahtar Kökü) ve Mnemonic (Kurtarma Kelimeleri):** Blokzincir cüzdanlarının temelini oluşturur; bu temelden private key, private key'den public key ve public key'den de cüzdan adresi türetilir.
  * **Seed / Seed Phrase:** Cüzdanımızın ve içerisindeki tüm hesapların matematiksel olarak türetildiği ham rastgele veri veya ana matristir.
  * **Mnemonic (BIP-39 Standardı):** Karmaşık seed *(ikili/hex)* verisini insanın okuyup saklayabilmesi için 12 veya 24 kelimelik bir liste haline getirilmiş biçimidir. Seed ile mnemonic pratikte aynı anlamda, yani cüzdanın ana yedek anahtarı olarak kullanılır.
* **Private Key:** Seed/mnemonic yapısından türetilen, cüzdanınızdaki varlıkları harcamanızı ve işlemleri imzalamanızı sağlayan gizli dijital şifredir.
* **Public Key:** Özel anahtardan tek yönlü matematiksel bir algoritmayla türetilen, başkalarıyla paylaşılabilen şifreleme anahtarıdır.
* **Wallet Address:** Public key'in kısaltılıp çeşitli hata testlerinden geçirilmesiyle elde edilen, tıpkı IBAN gibi para yatırma/alma işlemleri yaptığı için kullanıma hesabınızdır.

**Hiyerarşik Türetim Süreci:**
1. 12 veya 24 kelimelik Mnemonic cümlesi bir **Seed** oluşturur. Bu Seed üzerinden hiyerarşik bir türetme ile cüzdanınızdaki birden fazla private key *(veya coin türü)* üretilir.
2. Her bir Private Key, tek yönlü bir kriptografik algoritma kullanılarak bir **Public Key**'e dönüştürülür. Bu işlem tek yönlüdür; Public Key'den Private Key'e geri dönülemez.
3. Public Key de özetlenip kısaltılarak **Cüzdan Adresi** oluşturulur.

### Entropi, Checksum ve BIP Standartları
* **Entropi:** Biz cüzdan oluştururken bilgisayarımızın veya telefonumuzun donanım bileşenleri tarafından üretilen rastgele sayıdır. Genellikle 128-256 bit arasında bir uzunluğa sahiptir. Entropi ne kadar yüksek ve tahmin edilemez ise, bir başkası tarafından tahmin edilme ihtimali o kadar imkânsız hale gelir.
* **Checksum:** Üretilen entropinin sonuna eklenen küçük bir kontrol verisidir. Kelimeleri cüzdana geri girerken bir kelimeyi yanlış yazar veya sırasını karıştırırsanız cüzdan *"geçersiz seed"* uyarısı verir.

| Standart | İlgili Olduğu Aşama | Görevi |
| :--- | :--- | :--- |
| **BIP-39** | Mnemonic Oluşturma Aşaması | Karmaşık sayısal entropiyi Seed Phrase'e dönüştürür. (Donanımınız önce rastgele bir sayı/entropi üretir, sonuna kontrol kodunu/checksum ekler ve bunu 2048 kelimelik bir listeden seçtiği 12-24 kelimeye çevirir. Daha sonra PBKDF2 ile bir Master Seed'e dönüştürülür.) |
| **BIP-32** | Mimari Ağaç Yapısı | BIP39'dan gelen Master Seed'i kullanarak tek bir master anahtara ait onlarca alt hesap üretebilen hiyerarşik ve deterministik (HD) cüzdan yapısını kurar. (Bu bir ağaç gibidir; anahtar seed cüzdanın mimarisini oluşturur. Sonsuz sayıda alt dallar/hesaplar türetilmesini sağlar.) |
| **BIP-44** | Düzen ve Etiketleme Aşaması | BIP32'nin kurduğu ağaç yapısına bir mantık getirir. Farklı kripto paraların (Bitcoin, Ethereum vb.) ve hesapların hangi köklerde duracağını standartlaştırır. (Cüzdana bir türetme yolu / derivation path çizer; örn: `m/44'/0'/0'/0/0` yolu Bitcoin adresini verirken `m/44'/60'/0'/0/0` yolu Ethereum adresini verir.) |

### Cüzdan Uygulaması, Hesap ve Mahremiyet
* **Cüzdan Uygulaması vs. Hesap:**
  * **Cüzdan Uygulaması:** Anahtarlarınızı saklayan ve blokzincirdeki varlıklarınızı görmenizi sağlayan bir programdır *(Metamask, Trust Wallet)*. Bu uygulama içinde BIP32/44 standartları sayesinde oluşturulan, kendine ait adresi ve gizli anahtarı olan bağımsız alt birimlerdir.
  * Cüzdan uygulaması fiziksel bir cüzdan değildir; account'lar cüzdandaki farklı banka kartları olur.
* **Adresi Paylaşmak vs. Anahtarı Paylaşmak:**
  * **Adresi Paylaşmak:** Mağazanın posta kutusunu / IBAN'ını paylaşmak gibidir.
  * **Anahtarı Paylaşmak:** Mağazanın kasasının anahtarını *(Seed Phrase / Private Key)* paylaşmak gibidir.
* **Adres Paylaşımının Mahremiyet Etkisi:**
  * Adresinizi birine verdiğinizde panel cüzdanını arar ve o ağa giren tüm finansal geçmişinizi görebilir:
    1. Anlık bakiye
    2. Kimden, ne zaman, ne kadar para alındığı
    3. Nerelere harcama *(etkileşim)* yapıldığı
  * *Çözüm:* BIP44 standardı her işlem için yeni adres üreterek buna engel olabilir.

| Kriter | Cüzdan Uygulamasının Silinmesi | Kurtarma Bilgisinin Kaybolması |
| :--- | :--- | :--- |
| **Paranın Durumu** | Paranız blokzincirde güvendedir | Paranız blokzincirde kalır ama erişim sonsuza dek kaybolur |
| **Geri Döndürülebilirlik** | %100 geri döndürülebilir | Geri döndürülemez |
| **Çözüm Yolu** | Uygulamayı yeniden indirip kurtarma kelimelerini yazmak | Uygulama silindiğinde veya cihaz bozulduğunda varlıklar yedeklenemez |
| **Güvenlik Riski** | Telefonunuz çalınmadığı sürece sıfırdır | Kelimeler başkalarının eline geçerse paranız anında çalınır; sadece siz kaybettiyseniz kimse dokunamaz |

---

## 4. Bitcoin, Ethereum ve Token (İP 04)

* **Bitcoin:** İnternetin dijital altını ve güvenli para sistemidir.
  * **Amacı:** Güvenli değer saklamaktır. Merkezi bir otoriteye ihtiyaç duymayan güvenli ve sansüre dayanıklı bir alternatif para sistemi *(21 milyon ile sınırlı)*.
  * **Programlanabilirliği:** Güvenlik için kısıtlı olarak sunuldu. Sadece basit transferler yapar, loop çalıştırmaz. Script dili vardır.
* **Ethereum:** İnternetin küresel bilgisayarıdır. Amacı akıllı sözleşmeler ve merkeziyetsiz uygulamalar çalıştırmaktır.
  * Sansüre dayanıklı bir yazılım ve bilgi işlem platformudur.
  * Ethereum üzerindeki bilgisayar ağlarının çalıştırdığı kendi sanal makinesi *(Ethereum Virtual Machine - EVM)* vardır.
  * **Smart Contract:** Solidity ile yazılır.
  * **Programlanabilirliği:** Sınırsızdır. Kodlanabilen her türlü finansal senaryoyu otomatik yürütür.

| Özellik | Bitcoin (BTC) | Ethereum (ETH) |
| :--- | :--- | :--- |
| **Birincil Kimlik** | Dijital Altın / Değişim Aracı | Küresel Akıllı Sözleşme Platformu |
| **Programlanabilirlik** | Çok kısıtlı ve sınırlı mimari (Script) | Sonsuz esnek (Solidity) - Turing Complete (Evet) |
| **Arz Politikası** | 21 milyon ile kesin sınırlı (Enflasyonist değil) | Yakım ve işleyiş algoritmalarına göre yönü yapılı |
| **Ana İşlevi** | Sadece değer (para) transferi odaklı | Token üretimi, DeFi, NFT, DAO, dApp ve veri yönetimi |
| **Mutabakat Yapısı** | Proof-of-Work | Proof-of-Stake |

### Native Varlık ve Token Kavramları
Blokzincir dünyasındaki varlıklar üretilme ve ait oldukları ağ ile olan ilişkilerine göre ikiye ayrılır:
1. **Native Varlık (Yerel Kripto Para):** Bir blokzincirin kendi temel altyapısında var olan, ağın güvenliğini sağlayan ve işlem masraflarını *(gas)* ödemek için kullanılan ana para birimidir.
   * **ETH:** Ethereum ağının kendi yerel parasıdır.
2. **Token (Belirteç):** Bir blokzincir ağının üzerine sonradan akıllı sözleşmeler aracılığıyla inşa edilen, o ağın kendi malı olmayan dijital varlıklardır. İşlem ücretlerini doğrudan kendi cinsinden ödeyemezler.
   * **USDC:** Ethereum ağı üzerinde akıllı sözleşmeyle üretilmiş bir tokendir. İşlem ücreti ödenirken ağın kendi parası ETH ile ödeme yapılır.
   * *Özet:* Herhangi bir blokzincirin doğrudan **ETH** ile ödül ve ETH aktarımında kullanılması → Native varlıktır.

| Kavram | Özelliği | Benzersizliği | Standardı |
| :--- | :--- | :--- | :--- |
| **Stablecoin** | Değerini sabit kripto para | Birbiriyle tamamen aynıdır | Genellikle ERC-20 standardı |
| **NFT** | Değiştirilemez dijital varlık | Her parça tamamen eşsizdir | Ayrı standartlar kullanılır (ERC-721 gibi) |
| **ERC-20** | Teknik kod şablonu | Değiştirilebilir varlık standardı | Ethereum üzerindeki stablecoin ve token altyapısıdır |

### Mainnet ve Testnet
* **Mainnet (Ana Ağ):** Gerçek paranın ve ekonomik değerin döndüğü resmi blokzincirdir.
* **Testnet (Test Ağı):** Tek amacı geliştiricilerin uygulamalarını ve kodlarını asıl ağa almadan denemeleri için kurulan, paranın bir değeri olmayan simülasyon ortamıdır.
* **Neden Ayrılır?**
  1. Maliyet
  2. Güvenlik → gerçek paralar vardır
  3. Hata toleransı → testnette yazılıma yeni sürüm verilir, mainnet'te geçiş yapılmaz.
* **Test ETH ve Test USDC:** Hiçbir ekonomik değere sahip değildir. Yalnızca yazılımın doğru çalışıp çalışmadığını denemek için kullanılan dijital simülasyon araçlarıdır.

* **Yorum - Etkinliğe Giriş Hakkını Temsil Etmek İçin Mutlaka Token Gerekir mi?**
  * Hayır, mutlaka token gerekmez. Bir QR kod, bir e-posta onayı veya sadece kripto cüzdan adresinizin bir listede kayıtlı olması *(whitelist)* bile yeterli olabilir.
  * Token kullanmak sadece bu etkinliğe girme hakkını ekstra güvenli transfer edilebilir ve dijital cüzdan katılabilen bir hakka dönüştürür; bu bir operatör zorunluluğu değildir.

---

## 5. Akıllı Sözleşme ve ABI (İP 05)

* **Smart Contract (Akıllı Sözleşme):** Belirli şartlar gerçekleştiğinde aracıya ihtiyaç duymadan kendiliğinden çalışan dijital kod bloklarıdır. Blokzincir üzerinde değiştirilemez kurallar gibi işlerler.
* **EVM (Ethereum Virtual Machine):** Ethereum ağının merkezindeki küresel sanal bilgisayardır. Akıllı sözleşmelerin kodlarını okur, çalıştırır ve tüm ağın aynı sonuçları üretmesini sağlar.
* **State (Durum):** Blokzincir bilgisayarının o anki canlı hafızasının anlık fotoğrafıdır. Hangi cüzdanda ne kadar para olduğu, akıllı sözleşmelerin güncel verileri gibi tüm sistem bilgileri "state" içinde tutulur ve her yeni işlemle birlikte güncellenir.

**Kodun Derlenme ve Çalışma Akışı:**
`Source Code` → `Compilation` → `Bytecode`
* **Source Code:** Yazılımcının Solidity gibi diller kullanarak yazdığı, insan tarafından okunabilen ham kod satırlarıdır.
* **Compilation:** İnsan diline yakın olan kaynak kodun, blokzincir bilgisayarının *(EVM)* anlayabileceği dile dönüştürme sürecidir. Bu işleme **compile** yapmak denir.
* **Bytecode:** Derleme sonucunda ortaya çıkan, EVM'nin okuyabildiği tamamen 16'lık sayı ve harflerden oluşan karmaşık kod yığınıdır.
* **Deploy:** Derlenmiş bu bytecode'un bir işlem aracılığıyla blokzincir ağına yüklenmesi ve kalıcı bir adrese kaydedilmesidir.

### ABI (Application Binary Interface)
* İnsan tarafından yazılan yazılımlar *(web siteleri, mobil uygulamalar)* ile blokzincirdeki okunması imkânsız makine kodu *(Bytecode)* arasında bir tercüman görevi görür.
* **Ne Zaman Elde Edilir?** ABI, kaynak kodun *(Solidity)* derlenme *(compilation)* işlemi yapıldığı anda elde edilir. Yazılımcı kodunu derlediğinde, compiler tıpkı çifte çekirdekli bir fabrika gibi çalışır: Bir yandan **Bytecode** *(sözleşme blokzincire yüklenecek - deploy)*, diğer yandan **ABI** *(JSON formatında bir fonksiyon listesi)* üretir. Sözleşmeyi yayınlamadan ABI zaten elimizdedir.
* **Bir Sözleşmenin Adresi Dışında Hangi Arayüz Bilgilerine İhtiyaç Duyulabilir?**
  1. Sözleşmenin ABI bilgisi *(JSON şablonu)* → sözleşmenin hangi fonksiyonlara sahip olduğunu, hangi parametreleri kabul ettiğini belirtir.
  2. Fonksiyon imzaları *(Function Signatures / Selectors)*
  3. Kullanılan Token / Kontrat Standartları *(ERC-20, ERC-721, ERC-1155 gibi)*

### Read Operations vs. Write Operations
| Özellik | Read Operations (Veri Okuma) | Write Operations (Durum Değiştiren İşlem) |
| :--- | :--- | :--- |
| **Gas Ücreti** | Yok (Ücretsiz) | Var (Maliyetli) |
| **Cüzdan Onayı** | Gerektirmez | Dijital imza şarttır |
| **Bekleme Süresi** | Yok (Anında sonuç) | Var (Blok onay süresi kadar) |
| **Ağa Etkisi** | Sadece düğümlerden veri çeker | Tüm ağın durumunu (State) günceller |
| **Örnek** | Bir cüzdanın bakiyesini sorgulamak | Birine token transfer etmek veya akıllı sözleşmeye bilgi kaydı girmek |

### Kaynak Kodu Verify Etmek vs. Security Audit
* **Kaynak Kodu Verify Etmek:** Blokzincirinde yayınladığınız bytecode ve çalıştırdığınız internette paylaştığınız Solidity kaynak kodunun birebir aynı olduğunu kanıtlar.
* **Security Audit (Güvenlik Denetimi):** İle kesinlikle aynı şey değildir. Verification kodun şeffaflığını sağlar; Audit ise kodun sağlamlığını ve güvenliğini test eder *(hacklenme açığı, mantık hatası)*.

* **Yorum - Aynı Kod İki Farklı Adrese Yayınlanınca Kayıtları Neden Ayrı Olabilir?**
  * Aynı kod iki farklı adrese yayınlandığında kayıtların ayrı olmasının sebebi, her sözleşmenin blokzincirin "state" hafızasında kendine özel, bağımsız ve izole bir saklama alanına *(storage)* sahip olmasıdır.

---

## 6. RPC, Explorer ve Event (İP 06)

* **RPC (Remote Procedure Call - Uzaktan Yordam Çağrısı):** Bir bilgisayar veya uygulamanın, başka bir bilgisayardaki bir fonksiyonu veya blokzincir düğümündeki *(node)* bir kod parçasını, sanki kendi yerel kodunu çalıştırıyormuş gibi çalıştırmasını sağlayan bir iletişim modelidir.
* **RPC Endpoint (RPC Uç Noktası):** Bu uzaktan fonksiyon çağırma isteklerinin nereye gönderileceğini belirten dijital adres *(genellikle URL veya IP)*.
* **Client (İstemci):** Bu komut veya veriyi isteyen taraf.
* **Node:** Blokzincir ağının verisini tutan ve doğrulayan gerçek sunucu *(HTTP, WebSocket ya da TCP üstünden)*.
* **RPC Provider (RPC Hizmet Sağlayıcısı):** Bu sunucuları kuran, bakımını yapan ve dış dünyaya RPC endpoint adresleri üzerinden kiralayan altyapı şirketidir. Mavi arka planda yüzlerce güçlü node çalıştırır ve bunları kesintisiz, yüksek hızlı bir altyapı haline getirir *(Alchemy, Infura, QuickNode vb.)*.

**RPC Süreci:**
1. Bir RPC isteği uygulama tarafından oluşturuluyor.
2. Bu istek *(arka planda)* RPC provider'ın bize verdiği RPC endpoint adresine iletiliyor.
3. Provider, bu isteği kendi veri merkezindeki Node sunucusuna yönlendiriyor.
4. Node kendi kaydında işlemi yapıp provider üzerinden ulaştırıyor.

* **Block Explorer (Blok Gezgini):** Bir blokzincir ağındaki tüm işlemleri, blokları, cüzdan adreslerini ve akıllı sözleşmeleri herkesin gerçek zamanlı olarak görüntülemesini sağlayan blokzincir arama motorudur *(Etherscan (Ethereum), Solscan (Solana), Blockchain.com (Bitcoin) vb.)*.
* **Kesinti Durumu:** Bir Block Explorer web sitesinin veya tek bir RPC adresinin kapanması, blokzincir ağının durduğu anlamına gelmez. Binlerce bağımsız node sayesinde kesintisiz olarak çalışmaya ve yeni blok üretmeye devam eder.

### Event / Log, Güncel State ve Indexer
* **Event (Log) Kayıtları:** Blokzincirde geçmişte yaşanmış olayların günlüğüdür. Sadece tarihçesini tutarken sözleşmenin güncel state'ini değiştirmezler.
* **Sözleşmenin Güncel State'i:** Değişkenlerin şu anki son değeridir. Akıllı sözleşmeler kendi ürettikleri logları okuyamazlar; state verilerini doğrudan okuyabilir ve değiştirebilirler.
* **Indexer (İndeksleyici):** Blokzincir üzerindeki karmaşık ve dağınık ham verileri *(bloklar, işlemler, event/log kayıtları)* sürekli olarak dinleyip, bunları neden sorgulayabileceği düzenli bir veritabanına *(PostgreSQL vb.)* dönüştüren arka plan yazılımıdır.
  * *Özet:* Blokzincire veri sağlamak ve arama yapmak için tasarlanmamış olmasından eriştiği gider.
* **Yorum - Explorer Olmadan Bir Kaydı Kontrol Etmek İçin Hangi Yolu Araştırırdınız?**
  * Doğrudan RPC endpoint adresine teknik sorular gönderir veya kendi Node sunucumuz üzerinden okuyarak kontrol edebiliriz.

---

## 7. Bir İşlemin Yolculuğu (İP 07)

### Cüzdan İşlemi Farkları
1. **Connect Wallet (Cüzdan Bağlamak):** Merkeziyetsiz bir uygulamaya *(dApp)* genel cüzdan adresini göstermektir → **Ücretsiz, risksiz**.
2. **Sign Message (Mesaj İmzalamak):** Private key'imizi kullanarak bir metni kriptografik olarak onaylamaktır → **Ücretsiz, dikkatli olunmalı**.
3. **Send Transaction (İşlem Göndermek):** Blokzincir ağının state'ini kalıcı olarak değiştiren bir talimat yayınlamaktır → **Ağ ücreti gerektirir, en riskli adımdır**.

### İşlem ve Ağ Terimleri
* **Gas Limit:** Bir işlemin gerçekleşmesi için harcamaya razı olduğunuz maksimum hesaplama birimi miktarıdır.
* **Gas Used:** İşlem gerçekleştiğinde / tamamlandığında ağın gerçekte tükettiği kesin hesaplama birimi miktarıdır. Gas Limit'ten daha az harcanırsa artan kısım cüzdanınıza iade edilir.
* **Gas Fee / Transaction Fee:** İşleminizin blokzincire kaydedilmesi için ağ doğrulayıcılarına ödediğiniz toplam maliyettir.
  * `(Gas Used x Gas Price)` ile hesaplanır ve ağın kendi kripto parasıyla ödenir.
* **Nonce (İşlem Sıra Numarası):** Cüzdanınızdan o ana kadar gönderilen toplam işlem sayısını takip eden bir sayaçtır. İlk işlem `0` numarasını alır ve her yeni işlemde bir artar.
* **Chain ID (Ağ Kimliği):** İşlemin hangi blokzincir ağı için oluşturulduğunu belirten benzersiz bir kimlik numarasıdır. Başka bir ağda izinsiz çalıştırılmasını önler.
* **TxID / Transaction Hash (İşlem Özeti / Kimliği):** Blokzincirde gerçekleştirilen her bir işlemin benzersiz parmak izi veya makbuz numarasıdır. Gönderici adresi, alıcı adresi, miktar ve zaman damgası gibi verilerin kriptografik olarak şifrelenmesiyle üretilen 64 karakterlik bir koddur.
* **Contract Address:** Blokzincir ağına yüklenen belirli bir akıllı sözleşmenin *(smart contract)* ikamet ettiği benzersiz adrestir. Arkasında private key yerine program kodu bulunur.
* **Block Hash (Blok Özeti / Kimliği):** Onaylanan işlemlerin gruplandırılarak kaydedildiği bir bloğun benzersiz kriptografik kimliğidir.
* **Pending (Beklemede):** İşlemin cüzdanınızdan çıktığını, ağa yayıldığını ve havuzda *(mempool)* doğrulayıcılar tarafından sıraya alınmayı beklediğini gösterir. Bu aşamadayken iptal edilebilir veya hızlandırılabilir.
* **Receipt (İşlem Makbuzu):** İşlem bir bloğa dahil edilip ağ tarafından işlendikten sonra blokzincirin ürettiği kesin sonuç belgesidir. Ne kadar gas harcandığını, hangi bloğa kaydedildiğini, işlemin başarılı olup olmadığını ve varsa akıllı sözleşme olay kayıtlarını *(event logs)* barındırır.
* **Status (Durum):** Receipt'in içinde yer alan ve işlemin nihai sonucunu bildiren göstergedir. **Success** *(Başarılı)* veya **Failed / Reverted** *(Başarısız)* değerlerini alır.
* *Not:* **Bir işlemin hash koduna sahip olması, transferin kesinleştiği anlamına gelmez.**

### İşlem Yaşam Döngüsü Akış Şeması
1. **İmzalama (Signing):**
   * Private key ile işlem onaylanır.
   * Nonce, Gas Limit ve Chain ID belirlenir.
2. **Gönderme (Broadcasting):**
   * İmzalı işlem node'lara iletilir.
   * Benzersiz bir TxID *(Transaction Hash)* üretilir.
3. **Bekleme (Pending / Mempool):**
   * İşlem havuzda *(mempool)* sıraya alınmayı bekler. *(İlk giriş anı / durdurulamaz; sadece müdahale edilebilir).*
4. **Bloğa Alınma (Mining / Validation):**
   * Doğrulayıcılar işlemi seçer ve çalıştırır.
   * İşlem bir bloğa eklenir ve Block Hash oluşur.
5. **Sonuç Kontrolü (Receipt & Status):**
   * Receipt ve Gas Used kesinleşir.
   * **STATUS: SUCCESS:** İşlem başarıyla bitti, varlıklar transfer edildi.
   * **STATUS: FAILED / REVERTED:** İşlem hata verdi, varlıklar iade edildi, harcanan gas kesildi.

* **Yorum - "İşlem Başarısız" ile "Sonucunu Öğrenemedim" Neden Farklıdır?**
  * **"İşlem başarısız"** → Kesinleşmiş başarısız sonuçtur.
  * **"Sonucunu öğrenemedim"** → Kesin değil veya node'dan yanıt alınamıyor *(belirsizlik durumu)*.

---

## 8. Ekosistemi Tanı (İP 08)

* **Web3:** Geleneksel internette *(Web 2)* verilerimiz ve hesaplarımız Google, Meta gibi büyük şirketlerin sunucularında tutulur. Web3 *(yeni nesil internet)* ise verilerin ve dijital paraların tamamen sizin kripto cüzdanınızda durduğu, hiçbir şirketin hesabınızı kapatamadığı bu merkezi olmayan büyüme sistemidir.
* **L1 (Layer 1 / Ana Blokzincir Ağı):** Kendi güvenlik kuralları ve bilgisayarı olan ana blokzincir sistemleridir *(Örn: Ethereum, Bitcoin, Solana)*.
* **L2 (Layer 2 / İkinci Hız Katmanı):** L2 ağları yükleme işlemi kendi içinde çok ucuza ve saniyeler içinde toplar, ardından hepsini tek bir paket halinde özetleyerek ana ağa *(L1)* kaydeder.
* **DeFi (Merkeziyetsiz Finans):** Banka şubesi, müşteri temsilcisi veya mesai saati olmayan dijital finans sistemleridir.
* **DAO (Merkeziyetsiz Otonom Organizasyon):** Patronu veya yönetim kurulu olmayan dijital bir kooperatiftir. Kurallar değiştirilemez blokzincir kodlarına yazılmıştır. O topluluğun token'ına sahip olan üyeler bir şeylere oylama yaparak karar verir.
* **Oracle (Dış Dünya Veri Sağlayıcısı):** Dış dünyadaki bilgileri *(altın, maç skoru)* güvenli bir şekilde blokzincirin içine aktaran haberci sistemlerdir.
* **Bridge (Ağlar Arası Köprü):** Farklı blokzincir ağları arası transfer tünelidir. Bir ağdaki varlığı kilitleyip diğer ağda birebir karşılığını üretir.
* **Zero-Knowledge Proof - Sıfır Bilgi İspatı (ZKP):** Bir sırrı söylemeden o sırrı bildiğinizi kanıtlama yöntemidir. Ağların çok daha hızlı çalışmasına imkân tanır.

### İleri Alan Kullanım Örnekleri
* **Dijital Kimlik (DID):** Sıfır bilgi ispatı *(ZKP)* ile yaş ve vatandaşlık doğrulaması.
* **RWA (Real-World Assets):** Tokenize edilmiş arsa hisse tahvilleri veya gayrimenkul yatırımı.
* **DePIN:** Topluluk tabanlı kablosuz internet ve harita ağları.

### Zero-Knowledge (ZK) Kanıt Mantığı ve Gizlilik
* ZK teknolojisi temel olarak *"bir kurala uyulduğunu"* veya *"belirli bir şarta sahip olunduğunu"* matematiksel olarak ispatlar. Bunu yaparken o kurala ait özel verileri tamamen gizli tutar.
  * *Örn:* İşlemin kurallara uygun, geçerli ve doğru olduğu **kanıtlanır**; işlemi yapan kişinin kimliği, hesap bakiyesi, transfer edilen tutar veya kişisel veriler **saklanır**.
* **"ZK kullanılıyor" tüm işlemlerin gizli olduğu anlamına gelmez** *(çoğu zaman hız ve ölçeklenebilirlik için kullanıldığından)*.
* **ZK Örneği (Ev Kiralama Senaryosu):**
  * **Durum:** Bir ev kiralamak istiyorsunuz ve ev sahibi kiranın en az 3 katı kadar aylık geliriniz olduğunu görmeyi şart koşuyor.
  * **Kanıtlanan Şey:** Gelirinizin alt sınırın üzerinde olduğu.
  * **Saklanan Bilgi:** Tam maaş tutarı, çalıştığınız şirket, banka hesap hareketleri ve harcama alışkanlıkları.
  * **İşleyiş:** Banka hesap dökümü yerine banka veya dijital cüzdandan ürettiğiniz bir ZK ispatını paylaşırsınız.


---

## 9. Gerçek Bir Blokzincir Projesi: Uniswap (İP 09)

### Proje ve Kaynaklar
* **Seçilen Proje:** Uniswap, Ethereum üzerinde çalışan merkeziyetsiz bir token takas protokolüdür (DEX).
* **Resmî Kaynaklar:** Uygulama arayüzü `app.uniswap.org`, resmî dokümantasyon `docs.uniswap.org`.

### Hangi Problemi, Kimler İçin Çözüyor?
* **Problem:** Geleneksel finans sistemindeki ve merkezi borsalardaki aracı kurumlara bağımlılığı, sansür riskini ve üçüncü tarafa güvenme zorunluluğunu azaltır. Kullanıcı, varlıklarını borsaya teslim etmeden doğrudan kendi cüzdanından takas yapar.
* **Hedef Kitle:** Kripto varlıklarını hızlıca ve aracı olmadan takas etmek isteyen bireysel kullanıcılar; ayrıca havuzlara likidite ekleyerek ücret geliri elde etmek isteyenler.

### Zincir İçi (On-Chain) ve Zincir Dışı (Off-Chain) Ayrımı
| Kısım | Zincir İçi (On-Chain) | Zincir Dışı (Off-Chain) |
| :--- | :--- | :--- |
| **Neler?** | Token takası (örn. ETH verip başka bir token almak), likidite havuzuna para ekleme/çekme, akıllı sözleşmelerin çalışması | Web sitesinin tasarımı ve butonları, fiyat grafikleri, arayüz sunucuları, tarayıcıdaki cüzdan eklentisi (MetaMask vb.) |
| **Nerede kayıtlı?** | Blokzincirde, kalıcı ve herkes tarafından denetlenebilir | Şirketin ve kullanıcının kendi sunucu/cihazlarında |

### Neden Blokzincir? (Normal Veritabanıyla Farkı)
* Sistem merkezi bir sunucuda normal bir veritabanıyla çalışsaydı, işletmeci istediği zaman havuzları dondurabilir, kullanıcıların varlıklarına el koyabilir veya emirleri manipüle edebilirdi.
* Blokzincirde kurallar akıllı sözleşme koduna yazılıdır ve değiştirilemez; işlemler şeffaf biçimde herkes tarafından doğrulanabilir.
* Kullanıcı varlığını kendi cüzdanında tutar, her takas doğrudan sözleşmeyle yapılır.

### Kullanıcı Kime ve Neye Güveniyor?
* **Akıllı sözleşmelere:** Kullanıcı bir şirkete değil, arka planda çalışan ve kimsenin tek taraflı değiştiremediği sözleşme koduna güvenir.
* **Arayüze (işletmeciye):** Kullanıcı, `app.uniswap.org` adresinin doğru olduğuna ve arayüzün kendisini yanlış sözleşmeye yönlendirmediğine güvenir.
* **Veri sağlayıcılara:** Arayüzdeki fiyat, grafik ve işlem geçmişi gibi veriler RPC sağlayıcıları ve indexer servislerinden gelir. Bu veriler yanlış veya gecikmeli gösterilebilir; bu yüzden kesin sonuç için Explorer'daki işlem kaydına bakmak gerekir.
* **Cüzdana:** Tarayıcıdaki cüzdan eklentisinin güvenli çalıştığına ve private key'in korunduğuna güvenilir.

### Benim Yorumum
* **Güçlü Yön:** Aracıyı aradan çıkarır; izinsiz (permissionless) olarak herkes, 7/24 takas yapabilir ve varlıklar işlem sırasında kullanıcının kontrolünde kalır.
* **Sınırlama:** Ağ yoğunluğunda işlem ücretleri (gas fee) artabilir. Ayrıca akıllı sözleşmelerde bir yazılım açığı (bug) çıkarsa fonlar risk altına girebilir ve blokzincirdeki işlem geri alınamaz.  

