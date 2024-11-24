
const QRCode = require('qrcode'); // You'll need the 'qrcode' library installed

const url = 'https://raw.githubusercontent.com/kaelisalive/instructions.json'; // Change this to the URL of your hosted file

QRCode.toFile('qr-code.png', url, function (err) {
  if (err) throw err;
  console.log('QR code has been saved!');
});
