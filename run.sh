cd wizard
zip -r ../app.zip *
cd ..
echo '#!/usr/bin/env python'| cat - app.zip > start
chmod +x start
rm app.zip
./start
