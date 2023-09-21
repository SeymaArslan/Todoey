#  <#Title#>

CoreData da CRUD işlemlerinde  Read hariç her şey güncelleme veya yok etme yaratır. Temel olarak, kalıcı deponun içindeki verileri değiştirmeniz gerektiğinde her zaman context'i  (context.save()) çağırmamız gerekir. Yani bu değişiklikleri işlemek için kaydet.
Reading veya loadItems içinde yaptığımız gibi, saveItems yada context çağırmıyoruz, çünkü kalıcı bir değişim yok

Inheriting yaparken hücreler için özelleştirilmiş sınıfı belirtmeyi unutma

pod 'ChameleonFramework/Swift', :git => 'https://github.com/wowansm/Chameleon.git', :branch => 'swift5'
