![Icon](https://img.icons8.com/ios/452/live-photos.png)
# LivePhotoAlbum
В приложении вы можете увидеть коллекцию live картинок, а так же сохранить любую из них в фотопленку вашего телефона

![screenshot](Users/simba/Desktop/collectionPhoto.png)
![screenshot](Users/simba/Desktop/livePhoto.png)

# Release Notes
1. [1.0.0](https://github.com/ArsGrey/livephotoalbum/commit/eb5f715f97d9b4a0535fa6ceceac37e7bdded919)
   * Для данного приложения использована архитектура _MVP_. На первом экране реализовал коллекцию картинок, переход на второй модуль, реализовал протоколы. В _NetworkService_ использовал функции, в которых происходят _background URLSession_, затем вызываю их в _MainPresenter_ и в _DetailPresenter_. В самих презенторах использована вся бизнес логика. В _ModuleBuilder_ реализовал создание модулей. В _MainCollectionViewCell_ использовал _URLSession_ для скачивания даты и преобразования в _UIImage_. В _DetailViewController_ реализовано открытие картинки, по сильному нажатию которой загружается видео. Добавлена кнопка сохранения, которая непосредственно уведомляет о сохранении картинки в формате live в фотопленку.

2. [1.0.1](https://github.com/ArsGrey/livephotoalbum/commit/2be3a1e8ccf99228c8f89d6154e1418e37d88934)
   * Скачивание _data_ и преобразование в _UIImage_ перенес с _MainCollectionViewCell_ в _NetworkService_. В _MainPresenter_ использовал приватный метод в качестве передачи массива скачанных _data_. Создал _MainViewModel_ в качестве передачи массива _data_ во _view_. Уровень доступа оутлетов реализовал как приватный, классы указал как финальные. Все реализованные протоколы в расширениях реализовал в классах. 

3. [1.0.2](https://github.com/ArsGrey/livephotoalbum/commit/a6eb03d06acdd06d697f0bec7df8439a186076cb)
   * Внедрил DI Tranquillity
   * Создал отдельный _FileService_, в котором метод возвращает урл с сохраненным файлом. Зарегистрировал _FileService_ в DIContainer.
   * Создал _mock_ объекты, добавил тесты
