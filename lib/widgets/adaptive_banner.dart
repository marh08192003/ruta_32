import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdaptiveBanner extends StatefulWidget {
  const AdaptiveBanner({super.key});

  @override
  State<AdaptiveBanner> createState() => _AdaptiveBannerState();
}

class _AdaptiveBannerState extends State<AdaptiveBanner> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;
  bool _isSubmitting = false; // Bandera de bloqueo

  @override
  void initState() {
    super.initState();
    // Cargamos después del primer frame para tener el tamaño de pantalla listo
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadAd());
  }

  Future<void> _loadAd() async {
    if (_isSubmitting || !mounted) return;
    _isSubmitting = true;

    // 1. Limpieza rigurosa antes de crear uno nuevo
    if (_bannerAd != null) {
      await _bannerAd!.dispose();
      _bannerAd = null;
      if (mounted) {
        setState(() => _isLoaded = false);
      }
    }

    // 2. Obtener tamaño adaptativo
    final size = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
      MediaQuery.sizeOf(context).width.truncate(),
    );

    if (size == null) {
      _isSubmitting = false;
      return;
    }

    // 3. Crear y cargar
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/9214589741',
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }
          setState(() {
            _isLoaded = true;
            _isSubmitting = false;
          });
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
          _isSubmitting = false;
          debugPrint("Error al cargar banner: $err");
        },
      ),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    if (_bannerAd != null && _isLoaded) {
      return Container(
        color: const Color(0xFF101E33), // Color final de tu degradado
        child: SafeArea(
          child: SizedBox(
            width: _bannerAd!.size.width.toDouble(),
            height: _bannerAd!.size.height.toDouble(),
            child: AdWidget(ad: _bannerAd!),
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }
}
