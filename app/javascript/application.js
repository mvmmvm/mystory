// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import jquery from "jquery"
window.$ = jquery

document.addEventListener('turbolinks:load', function() {
    // turbolinks:load イベントでのJavaScriptの再実行
    // ここにページロード時に実行したいJavaScriptコードを記述する
    // 例：カテゴリのドロップダウンメニューの制御やスライドショーの設定など
  });
