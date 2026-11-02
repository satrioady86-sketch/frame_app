// FRAME - Film discovery (Flutter Web / responsive)
//
// SETUP
// 1) pubspec.yaml:
//      dependencies:
//        google_fonts: ^6.2.1
//      flutter:
//        assets:
//          - assets/images/
// 2) Taruh gambar (landscape untuk hero/kartu, portrait untuk "night owls")
//    di assets/images/ dengan nama persis seperti di class Img di bawah.
//    Kalau gambar belum ada, app tetap jalan dengan placeholder gradient.
// 3) flutter run -d chrome

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const FrameApp());

// ───────────────────────── THEME ─────────────────────────

class C {
  static const bg = Color(0xFF0B0D12);
  static const surface = Color(0xFF171B23);
  static const gold = Color(0xFFD9B26F);
  static const text = Color(0xFFF4EFE6);
  static const muted = Color(0xFF9AA0AB);
}

Color a(Color c, double o) => c.withAlpha((o * 255).round());

TextStyle serif(double size) => GoogleFonts.dmSerifDisplay(
      fontSize: size,
      color: C.text,
      height: 1.05,
    );

TextStyle sans(
  double size, {
  Color color = C.text,
  FontWeight weight = FontWeight.w400,
  double spacing = 0,
  double? height,
}) =>
    GoogleFonts.inter(
      fontSize: size,
      color: color,
      fontWeight: weight,
      letterSpacing: spacing,
      height: height,
    );

// ───────────────────────── DATA ─────────────────────────

/// Nama file gambar di assets/images/
class Img {
  static const heroLaskarPelangi = 'assets/images/laskar_pelangi_wide.jpg';
  static const heroMarlina = 'assets/images/marlina_wide.jpg';
  static const heroPengabdiSetan = 'assets/images/pengabdi_setan_wide.jpg';

  static const athirah = 'assets/images/athirah_wide.jpg';
  static const pengabdiSetan = 'assets/images/pengabdi_setan_wide.jpg';

  static const featureSumba = 'assets/images/sumba_landscape.jpg';

  static const copyOfMyMind = 'assets/images/a_copy_of_my_mind_portrait.jpg';
  static const siti = 'assets/images/siti_portrait.jpg';
}

class Film {
  final String title;
  final String year;
  final String duration;
  final String genre;
  final String rating;
  final String synopsis;
  final String image;
  final List<Color> fallback;

  const Film({
    required this.title,
    required this.year,
    required this.duration,
    required this.genre,
    this.rating = '13+',
    this.synopsis = '',
    required this.image,
    required this.fallback,
  });
}

const heroFilms = <Film>[
  Film(
    title: 'Laskar\nPelangi',
    year: '2008',
    duration: '2h 4m',
    genre: 'Drama',
    rating: 'SU',
    synopsis:
        'Di sebuah pulau tambang di Belitung, sepuluh anak dan dua guru '
        'menjaga sekolah reyot mereka tetap berdiri.',
    image: Img.heroLaskarPelangi,
    fallback: [Color(0xFF1E3A4C), Color(0xFF0B0D12)],
  ),
  Film(
    title: 'Marlina',
    year: '2017',
    duration: '1h 33m',
    genre: 'Drama',
    rating: '17+',
    synopsis:
        'Di padang sabana Sumba, seorang janda menempuh perjalanan sunyi '
        'untuk menuntut keadilan dengan caranya sendiri.',
    image: Img.heroMarlina,
    fallback: [Color(0xFF5B3A1E), Color(0xFF0B0D12)],
  ),
  Film(
    title: 'Pengabdi\nSetan',
    year: '2017',
    duration: '1h 47m',
    genre: 'Horor',
    rating: '17+',
    synopsis:
        'Setelah ibu mereka wafat, sebuah keluarga mulai menyadari bahwa '
        'rumah itu tidak pernah benar-benar sepi.',
    image: Img.heroPengabdiSetan,
    fallback: [Color(0xFF2B1B1B), Color(0xFF0B0D12)],
  ),
];

const continueFilms = <Film>[
  Film(
    title: 'Pengabdi Setan',
    year: '2017',
    duration: '42 min left',
    genre: 'Horor',
    image: Img.pengabdiSetan,
    fallback: [Color(0xFF3A2222), Color(0xFF0B0D12)],
  ),
  Film(
    title: 'Athirah',
    year: '2016',
    duration: '1h 12m left',
    genre: 'Drama',
    image: Img.athirah,
    fallback: [Color(0xFF3C4A2E), Color(0xFF0B0D12)],
  ),
];

const nightFilms = <Film>[
  Film(
    title: 'A Copy of My Mind',
    year: '2015',
    duration: '1h 56m',
    genre: 'Romance',
    synopsis: 'Joko Anwar',
    image: Img.copyOfMyMind,
    fallback: [Color(0xFF12304D), Color(0xFF0B0D12)],
  ),
  Film(
    title: 'Siti',
    year: '2014',
    duration: '1h 28m',
    genre: 'Drama',
    synopsis: 'Eddy Cahyono',
    image: Img.siti,
    fallback: [Color(0xFF2A2A2E), Color(0xFF0B0D12)],
  ),
];

// ───────────────────────── APP ─────────────────────────

class FrameApp extends StatelessWidget {
  const FrameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FRAME',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: C.bg,
        splashFactory: NoSplash.splashFactory,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, box) {
          final w = box.maxWidth;
          final desktop = w >= 1000;
          final mobile = w < 640;
          final pad = mobile ? 20.0 : (desktop ? 56.0 : 36.0);

          return SingleChildScrollView(
            child: Column(
              children: [
                HeroBanner(desktop: desktop, mobile: mobile, pad: pad),
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1280),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: pad),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 40),
                          _TopRow(desktop: desktop),
                          SizedBox(height: desktop ? 56 : 44),
                          _NightOwls(desktop: desktop),
                          const SizedBox(height: 64),
                          const _Footer(),
                          const SizedBox(height: 48),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ───────────────────────── SHARED WIDGETS ─────────────────────────

class Poster extends StatelessWidget {
  final String asset;
  final List<Color> fallback;
  final Alignment alignment;

  const Poster({
    super.key,
    required this.asset,
    required this.fallback,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      fit: BoxFit.cover,
      alignment: alignment,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (_, __, ___) => DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: fallback,
          ),
        ),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _ArrowLink extends StatelessWidget {
  final String label;
  const _ArrowLink(this.label);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: sans(12, color: C.muted)),
          const SizedBox(width: 6),
          const Icon(Icons.arrow_forward, size: 14, color: C.text),
        ],
      ),
    );
  }
}

// ───────────────────────── NAVBAR ─────────────────────────

class _NavBar extends StatelessWidget {
  final double pad;
  const _NavBar({required this.pad});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(pad, 28, pad, 0),
      child: Row(
        children: [
          Container(width: 3, height: 16, color: C.gold),
          const SizedBox(width: 8),
          Text(
            'FRAME',
            style: sans(15, weight: FontWeight.w700, spacing: 3),
          ),
        ],
      ),
    );
  }
}

// ───────────────────────── HERO ─────────────────────────

class HeroBanner extends StatefulWidget {
  final bool desktop;
  final bool mobile;
  final double pad;

  const HeroBanner({
    super.key,
    required this.desktop,
    required this.mobile,
    required this.pad,
  });

  @override
  State<HeroBanner> createState() => _HeroBannerState();
}

class _HeroBannerState extends State<HeroBanner> {
  int _index = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 6), (_) {
      if (!mounted) return;
      setState(() => _index = (_index + 1) % heroFilms.length);
    });
  }

  void _goTo(int i) {
    setState(() => _index = i);
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final film = heroFilms[_index];
    final height = widget.mobile ? 580.0 : (widget.desktop ? 640.0 : 600.0);
    final pad = widget.pad;

    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 800),
              child: SizedBox.expand(
                key: ValueKey('bg$_index'),
                child: Poster(
                  asset: film.image,
                  fallback: film.fallback,
                  alignment: Alignment.center,
                ),
              ),
            ),
          ),

          // Left → right darkening
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    a(C.bg, widget.mobile ? 0.85 : 0.92),
                    a(C.bg, widget.mobile ? 0.55 : 0.40),
                    a(C.bg, 0.0),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),

          // Bottom fade into page
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [a(C.bg, 0.0), a(C.bg, 0.0), C.bg],
                  stops: const [0.0, 0.62, 1.0],
                ),
              ),
            ),
          ),

          // Navbar (tanpa tombol search)
          Positioned(top: 0, left: 0, right: 0, child: _NavBar(pad: pad)),

          // Content
          Positioned(
            left: pad,
            right: pad,
            bottom: 84,
            child: Align(
              alignment: Alignment.centerLeft,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (child, anim) => FadeTransition(
                    opacity: anim,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.04),
                        end: Offset.zero,
                      ).animate(anim),
                      child: child,
                    ),
                  ),
                  child: _HeroContent(
                    key: ValueKey('c$_index'),
                    film: film,
                    mobile: widget.mobile,
                  ),
                ),
              ),
            ),
          ),

          // Indicators
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(heroFilms.length, (i) {
                final active = i == _index;
                return GestureDetector(
                  onTap: () => _goTo(i),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 3, vertical: 8),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: active ? 28 : 6,
                        height: 3,
                        decoration: BoxDecoration(
                          color: active ? C.gold : a(C.text, 0.35),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroContent extends StatelessWidget {
  final Film film;
  final bool mobile;
  const _HeroContent({super.key, required this.film, required this.mobile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 22, height: 1, color: C.gold),
            const SizedBox(width: 10),
            Text(
              "TONIGHT'S PREMIERE",
              style: sans(10,
                  color: C.gold, weight: FontWeight.w600, spacing: 2),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Text(film.title, style: serif(mobile ? 48 : 68)),
        const SizedBox(height: 16),
        Text(
          '${film.year}   ·   ${film.duration}   ·   ${film.genre}   ·   ${film.rating}',
          style: sans(12, color: C.muted),
        ),
        const SizedBox(height: 14),
        Text(
          film.synopsis,
          style: sans(13, color: a(C.text, 0.85), height: 1.6),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: const [
            _PrimaryButton(icon: Icons.play_arrow_outlined, label: 'Watch film'),
            _GhostButton(icon: Icons.add, label: 'My list'),
          ],
        ),
      ],
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final IconData icon;
  final String label;
  const _PrimaryButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        decoration: BoxDecoration(
          color: C.gold,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: C.bg),
            const SizedBox(width: 8),
            Text(label,
                style: sans(12, color: C.bg, weight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}

class _GhostButton extends StatelessWidget {
  final IconData icon;
  final String label;
  const _GhostButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        decoration: BoxDecoration(
          color: a(C.surface, 0.9),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: a(C.text, 0.08)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: C.text),
            const SizedBox(width: 8),
            Text(label, style: sans(12, weight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

// ───────────────────────── TOP ROW ─────────────────────────

class _TopRow extends StatelessWidget {
  final bool desktop;
  const _TopRow({required this.desktop});

  @override
  Widget build(BuildContext context) {
    final cont = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Pick up where you left off',
            style: sans(17, weight: FontWeight.w600)),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _ContinueCard(film: continueFilms[0])),
            const SizedBox(width: 16),
            Expanded(child: _ContinueCard(film: continueFilms[1])),
          ],
        ),
      ],
    );

    final feature = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('A little further from ordinary',
            style: sans(17, weight: FontWeight.w600)),
        const SizedBox(height: 16),
        const _FeatureCard(),
      ],
    );

    if (desktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 6, child: cont),
          const SizedBox(width: 40),
          Expanded(flex: 5, child: feature),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [cont, const SizedBox(height: 40), feature],
    );
  }
}

class _ContinueCard extends StatelessWidget {
  final Film film;
  const _ContinueCard({required this.film});

  @override
  Widget build(BuildContext context) {
    final progress = film == continueFilms[0] ? 0.62 : 0.35;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AspectRatio(
              aspectRatio: 16 / 10,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Poster(asset: film.image, fallback: film.fallback),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [a(C.bg, 0.0), a(C.bg, 0.75)],
                        stops: const [0.5, 1.0],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    bottom: 12,
                    child: Text(film.duration,
                        style: sans(10, color: a(C.text, 0.9))),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Stack(
                      children: [
                        Container(height: 2, color: a(C.text, 0.2)),
                        FractionallySizedBox(
                          widthFactor: progress,
                          child: Container(height: 2, color: C.text),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(film.title, style: sans(12, weight: FontWeight.w600)),
          const SizedBox(height: 3),
          Text('${film.year} · ${film.genre}',
              style: sans(10, color: C.muted)),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard();

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: AspectRatio(
          aspectRatio: 16 / 7.2,
          child: Stack(
            fit: StackFit.expand,
            children: [
              const Poster(
                asset: Img.featureSumba,
                fallback: [Color(0xFF6B4423), Color(0xFF1B2A3A)],
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [a(C.bg, 0.75), a(C.bg, 0.15)],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'THE ART OF GETTING LOST',
                      style: sans(8,
                          color: C.gold,
                          weight: FontWeight.w600,
                          spacing: 1.8),
                    ),
                    const SizedBox(height: 8),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text('Far from here', style: serif(30)),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Open roads. Unlikely turns. Unforgettable films.',
                      style: sans(9, color: a(C.text, 0.8)),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Explore 6 films',
                            style: sans(10, weight: FontWeight.w500)),
                        const SizedBox(width: 6),
                        const Icon(Icons.arrow_forward,
                            size: 12, color: C.text),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ───────────────────────── NIGHT OWLS ─────────────────────────

class _NightOwls extends StatelessWidget {
  final bool desktop;
  const _NightOwls({required this.desktop});

  @override
  Widget build(BuildContext context) {
    final intro = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('CURATED BY FRAME',
            style: sans(9, color: C.gold, weight: FontWeight.w600, spacing: 2)),
        const SizedBox(height: 14),
        Text('For the night owls', style: serif(26)),
        const SizedBox(height: 12),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 240),
          child: Text(
            'When the world goes quiet, stories come alive.',
            style: sans(12, color: C.muted, height: 1.6),
          ),
        ),
        const SizedBox(height: 18),
        const _ArrowLink('All 12'),
      ],
    );

    final cards = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _NightCard(film: nightFilms[0])),
        const SizedBox(width: 16),
        Expanded(child: _NightCard(film: nightFilms[1])),
      ],
    );

    if (desktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 300, child: intro),
          const SizedBox(width: 40),
          Expanded(child: cards),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [intro, const SizedBox(height: 28), cards],
    );
  }
}

class _NightCard extends StatelessWidget {
  final Film film;
  const _NightCard({required this.film});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AspectRatio(
              aspectRatio: 0.78,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Poster(asset: film.image, fallback: film.fallback),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          a(C.bg, 0.25),
                          a(C.bg, 0.0),
                          a(C.bg, 0.8),
                        ],
                        stops: const [0.0, 0.45, 1.0],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Text(film.duration,
                        style: sans(10, color: a(C.text, 0.9))),
                  ),
                  Positioned(
                    left: 12,
                    bottom: 14,
                    child: Row(
                      children: [
                        const Icon(Icons.play_arrow_outlined,
                            size: 15, color: C.text),
                        const SizedBox(width: 4),
                        Text('Watch film', style: sans(10)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(film.title, style: sans(12, weight: FontWeight.w600)),
          const SizedBox(height: 3),
          Text('A film by ${film.synopsis}',
              style: sans(10, color: C.muted)),
        ],
      ),
    );
  }
}

// ───────────────────────── FOOTER ─────────────────────────

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(width: 24, height: 1, color: a(C.text, 0.3)),
          const SizedBox(height: 18),
          Text(
            'Good films. No endless scrolling.',
            textAlign: TextAlign.center,
            style: serif(22),``
          ),
          const SizedBox(height: 10),
          Text('A fresh perspective, every week.',
              style: sans(10, color: C.muted)),
        ],
      ),
    );
  }
}