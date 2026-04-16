#!/bin/bash
cat > /var/www/html/index.html << HTML
<!DOCTYPE html>
<html>
<body>
  <img src="https://storage.yandexcloud.net/${bucket_name}/${object_key}" alt="nature">
</body>
</html>
HTML