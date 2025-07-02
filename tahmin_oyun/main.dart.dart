import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const SayiTahminUygulamasi());
}

class SayiTahminUygulamasi extends StatelessWidget {
  const SayiTahminUygulamasi({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TahminSayfasi(),
      debugShowCheckedModeBanner: false, //debug yazısını kaldırır
    );
  }
}

class TahminSayfasi extends StatefulWidget {
  const TahminSayfasi({super.key});

  @override
  State<TahminSayfasi> createState() => _TahminSayfasiDurumu();
}

class _TahminSayfasiDurumu extends State<TahminSayfasi> {
  final TextEditingController _tahminDenetleyici = TextEditingController();
  late int _dogruSayi;
  String _mesaj = '1 ile 100 arasında bir sayı tuttum. Tahmin et!';
  int _denemeSayisi = 0;

  @override
  void initState() {
    super.initState();
    _yeniSayiTut();
  }

  void _yeniSayiTut() {
    final rastgele = Random();
    _dogruSayi = rastgele.nextInt(100) + 1;
    _denemeSayisi = 0;
    _mesaj = '1 ile 100 arasında bir sayı tuttum. Tahmin et!';
    _tahminDenetleyici.clear();
  }

  void _tahminKontrolEt() {
    final girilenYazi = _tahminDenetleyici.text;
    final tahmin = int.tryParse(girilenYazi);

    if (tahmin == null) {
      setState(() {
        _mesaj = '⚠️ Lütfen geçerli bir sayı gir.';
      });
      return;
    }
    if (tahmin < 1 || tahmin > 100) {
       setState(() {
         _mesaj = '⚠️ Sadece 1 ile 100 arasında sayı giriniz.';
    });
    return;
  }
    _denemeSayisi++;

    setState(() {
      if (tahmin < _dogruSayi) {
        _mesaj = '🔺 Daha büyük bir sayı dene.';
      } else if (tahmin > _dogruSayi) {
        _mesaj = '🔻 Daha küçük bir sayı dene.';
      } else if (tahmin == _dogruSayi) {
        _mesaj =
            '🎉 Tebrikler! $_denemeSayisi denemede bildin.\nYeniden oynamak ister misin?';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sayı Tahmin Oyunu'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _mesaj,
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _tahminDenetleyici,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Tahminini gir',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _mesaj.contains('Tebrikler')
                  ? () {
                      setState(() {
                        _yeniSayiTut();
                      });
                    }
                  : _tahminKontrolEt,
              child: Text(_mesaj.contains('Tebrikler')
                  ? 'Yeniden Başla'
                  : 'Tahmin Et'),
            ),
          ],
        ),
      ),
    );
  }
}
