# PowerShell IP Scanner
```
1..254 | %{ping -n 1 -w 15 192.168.101.$_ | select-string "reply from"}
```
Bu PowerShell scripti, bir belirli bir IP adres aralığındaki tüm cihazlara ping atarak hangi IP adreslerinin aktif olduğunu tespit etmek için kullanılır. Detaylı bir şekilde inceleyelim:
```
1..254
```
Bu ifade, 1'den 254'e kadar olan tüm sayıları temsil eder. Buradaki sayılar, sonuçta IP adreslerinin son oktetini (dördüncü bölümü) temsil edecektir.
```
| %{
```
Burada % işareti, ForEach-Object cmdlet'inin kısa kullanımıdır. Bu cmdlet, sol taraftan gelen her bir nesne (bu durumda sayılar) için sağ taraftaki bloğu tekrar tekrar çalıştırır.
```
ping -n 1 -w 15 192.168.101.$_
```
  -n 1: Her IP adresine yalnızca bir kez ping atılmasını sağlar.
  -w 15: Ping cevabı için maksimum 15 milisaniye bekleme süresini belirler.
  192.168.101.$_: Burada $_ değişkeni, ForEach-Object tarafından döngüde sırayla alınan sayıyı temsil eder. Yani her dönüşte $_ değişkeni 1'den 254'e kadar değişir ve bu sayede 192.168.101.1'den 192.168.101.254'e kadar olan IP adreslerine ping atılır.
```
| select-string "reply from"
```
Bu komut, ping komutunun çıktısını filtreler ve yalnızca "reply from" ifadesini içeren satırları (yani ping'e cevap veren IP adreslerini) döndürür.

Scriptin Kullanımı

Bu script, ağda hangi cihazların çevrimiçi olduğunu hızlı bir şekilde tespit etmek için kullanılabilir. IP bloğu ve parametreler değiştirilerek sisteminiz için uygun hale getirmeniz önelidir. Özellikle ağ yöneticileri tarafından aşağıdaki amaçlar için kullanılır:

  Ağ Taraması: Ağ üzerinde aktif olan cihazları tespit etmek.
  Güvenlik Kontrolleri: Yetkisiz cihazların ağa erişip erişmediğini kontrol etmek.
  Ağ Bakımı: Ağ üzerindeki cihazların durumunu düzenli olarak kontrol ederek, olası problemleri önceden tespit etmek.

Neden Kullanılır?

  Hızlı Tarama: Büyük bir IP aralığını hızlıca tarayarak hangi cihazların çevrimiçi olduğunu belirleyebilir.
  Basitlik: Script çok basit ve anlaşılır olduğu için, özelleştirmeler yapmak veya belirli bir ağ segmentini hedeflemek kolaydır.
  Otomasyon: Bu tarama işlemini düzenli aralıklarla otomatik olarak çalışacak şekilde ayarlayabilirsiniz, böylece manuel kontrol ihtiyacını azaltırsınız.

Alternatrif olarak aşağıdaki scriptde kullanılabilir

```
1..255 | foreach-object { (new-object system.net.networkinformation.ping).Send("192.168.101.$_") } | where-object {$_.Status -eq "Success"} | select Address
```
Bu alternatif PowerShell scripti, bir IP adres aralığını taramak için kullanılan bir başka yöntemdir ve ağ üzerinde aktif olan cihazların IP adreslerini tespit etmek amacıyla kullanılır. Detaylı bir şekilde açıklayalım:
```
1..255
```
Bu ifade, 1'den 255'e kadar olan sayıları temsil eder. Bu sayılar, sonuçta IP adreslerinin son oktetini (dördüncü bölümü) oluşturur.
```
| foreach-object {
```
foreach-object cmdlet'i, sol taraftan gelen sayı dizisi üzerinde döngü yapar ve her bir sayı için sağ taraftaki bloğu çalıştırır.
```
(new-object system.net.networkinformation.ping).Send("192.168.101.$_")
```
  new-object system.net.networkinformation.ping: .NET Framework'ün System.Net.NetworkInformation.Ping sınıfından bir nesne oluşturur. Bu nesne, ağ üzerindeki cihazlara ICMP echo request göndermek için kullanılır.
  .Send("192.168.101.$_"): Oluşturulan ping nesnesi ile 192.168.101.x şeklinde belirtilen IP adresine ping gönderir. Burada $_ değişkeni, foreach-object tarafından sağlanan her bir sayıyı temsil eder.
```
| where-object {$_.Status -eq "Success"}
```
Bu komut, ping cevabının durumunu kontrol eder ve yalnızca başarılı (Success) olan cevapları filtreler. Yani sadece cevap veren (ulaşılabilir olan) IP adreslerini geçirir.
```
| select Address
```
select Address ifadesi, başarılı ping sonuçlarının IP adreslerini seçer ve listeler.

Scriptin Kullanımı

Bu script, özellikle aşağıdaki amaçlar için kullanılır:

  Ağ Taraması: Ağ üzerinde hangi cihazların aktif olduğunu tespit etmek.
  Güvenlik Denetimi: Yetkisiz cihazların ağa erişip erişmediğini kontrol etmek.
  Ağ Yönetimi: Ağ sağlığını ve cihazların bağlantı durumunu izlemek.

Neden Kullanılır?

  Daha Güçlü ve Esnek: .NET Framework kullanarak daha güçlü ve esnek bir yapı sunar.
  Detaylı Yanıt Seçenekleri: Ping sınıfı, zaman aşımı gibi ek bilgileri yönetme imkanı verir.
  Programatik Kontrol: Script, daha karmaşık senaryolarda genişletilebilir ve entegre edilebilir, örneğin başarısız pingler için yeniden deneme mekanizmaları ekleyebilirsiniz.

Bu scriptler, sistem ve ağ yöneticileri için vazgeçilmez bir araçtır, çünkü büyük ve dinamik ağ yapılarını etkili bir şekilde izlemelerine olanak tanır.

