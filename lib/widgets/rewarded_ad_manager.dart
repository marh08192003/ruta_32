import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class RewardedAdManager {
  RewardedAd? _rewardedAd;
  bool _isLoaded = false;
  int _numAttempts = 0;

  // Getter para que el GameScreen sepa si mostrar el botón o el aviso
  bool get isAdLoaded => _isLoaded;

  void loadAd() {
    if (_isLoaded) return; // Evitar cargas dobles si ya está listo

    RewardedAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/5224354917',
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          _isLoaded = true;
          _numAttempts = 0;
          debugPrint('Anuncio cargado y listo para usar');
        },
        onAdFailedToLoad: (error) {
          _numAttempts++;
          _rewardedAd = null;
          _isLoaded = false;
          if (_numAttempts <= 3) {
            Future.delayed(Duration(seconds: _numAttempts * 2), () => loadAd());
          }
        },
      ),
    );
  }

  void showAd({required Function onRewardEarned}) {
    if (_isLoaded && _rewardedAd != null) {
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _isLoaded = false;
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          _isLoaded = false;
          loadAd();
        },
      );

      _rewardedAd!.show(
        onUserEarnedReward: (ad, reward) {
          onRewardEarned();
        },
      );
      _rewardedAd = null;
      _isLoaded = false;
    }
  }
}
