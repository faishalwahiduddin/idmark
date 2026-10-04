import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/models/watermark_config.dart';
import '../../../core/utils/web_download_helper.dart';

class IdmarkShareTheme {
  final String name;
  final List<Color> bgGradient;
  final Color cardBg;
  final Color accentColor;
  final Color textPrimary;
  final Color textSecondary;
  final Color borderColor;
  final Color badgeBg;
  final Color badgeText;

  const IdmarkShareTheme({
    required this.name,
    required this.bgGradient,
    required this.cardBg,
    required this.accentColor,
    required this.textPrimary,
    required this.textSecondary,
    required this.borderColor,
    required this.badgeBg,
    required this.badgeText,
  });
}

class IdmarkShareDialog extends StatefulWidget {
  final WatermarkConfig config;
  final String sha256Hash;
  final String dateLabel;
  final int fileSizeBytes;

  const IdmarkShareDialog({
    super.key,
    required this.config,
    required this.sha256Hash,
    required this.dateLabel,
    required this.fileSizeBytes,
  });

  static Future<void> show({
    required BuildContext context,
    required WatermarkConfig config,
    required String sha256Hash,
    required String dateLabel,
    required int fileSizeBytes,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => IdmarkShareDialog(
        config: config,
        sha256Hash: sha256Hash,
        dateLabel: dateLabel,
        fileSizeBytes: fileSizeBytes,
      ),
    );
  }

  @override
  State<IdmarkShareDialog> createState() => _IdmarkShareDialogState();
}

class _IdmarkShareDialogState extends State<IdmarkShareDialog> {
  final GlobalKey _repaintBoundaryKey = GlobalKey();
  bool _isGenerating = false;
  bool _isStoryFormat = false; // false = 4:5 Feed, true = 9:16 Story
  int _selectedThemeIndex = 0;

  static const List<IdmarkShareTheme> _themes = [
    IdmarkShareTheme(
      name: 'Cyber Shield',
      bgGradient: [Color(0xFF0F172A), Color(0xFF1E293B)],
      cardBg: Color(0xFF1E293B),
      accentColor: Color(0xFF38BDF8),
      textPrimary: Color(0xFFFFFFFF),
      textSecondary: Color(0xFF94A3B8),
      borderColor: Color(0xFF0284C7),
      badgeBg: Color(0xFF0C4A6E),
      badgeText: Color(0xFF7DD3FC),
    ),
    IdmarkShareTheme(
      name: 'Emerald Safe',
      bgGradient: [Color(0xFF064E3B), Color(0xFF022C22)],
      cardBg: Color(0xFF065F46),
      accentColor: Color(0xFF10B981),
      textPrimary: Color(0xFFFFFFFF),
      textSecondary: Color(0xFFA7F3D0),
      borderColor: Color(0xFF059669),
      badgeBg: Color(0xFF064E3B),
      badgeText: Color(0xFF6EE7B7),
    ),
    IdmarkShareTheme(
      name: 'Obsidian Vault',
      bgGradient: [Color(0xFF18181B), Color(0xFF09090B)],
      cardBg: Color(0xFF27272A),
      accentColor: Color(0xFFA1A1AA),
      textPrimary: Color(0xFFFAFAFA),
      textSecondary: Color(0xFFA1A1AA),
      borderColor: Color(0xFF3F3F46),
      badgeBg: Color(0xFF3F3F46),
      badgeText: Color(0xFFE4E4E7),
    ),
    IdmarkShareTheme(
      name: 'Amber Proof',
      bgGradient: [Color(0xFF451A03), Color(0xFF1C1917)],
      cardBg: Color(0xFF78350F),
      accentColor: Color(0xFFF59E0B),
      textPrimary: Color(0xFFFFFFFF),
      textSecondary: Color(0xFFFDE68A),
      borderColor: Color(0xFFD97706),
      badgeBg: Color(0xFF451A03),
      badgeText: Color(0xFFFCD34D),
    ),
  ];

  String _buildShareText() {
    final c = widget.config;
    final buffer = StringBuffer();
    buffer.writeln('🛡️ BUKTI PROTEKSI DOKUMEN — IDMARK');
    buffer.writeln('📌 Keperluan Khusus: "${c.purpose.toUpperCase()}"');
    buffer.writeln('📅 Tanggal Stempel: ${widget.dateLabel}');
    buffer.writeln('🔒 Skor Privasi: ${c.privacyScore}/100');
    buffer.writeln('✂️ Sensor Permanen: ${c.redactions.length} Area Tertutup');
    buffer.writeln('🔑 SHA-256: ${widget.sha256Hash}');
    buffer.writeln('✅ Diproses 100% on-device tanpa server (Sesuai Panduan Kominfo RI)');
    buffer.writeln('\nLindungi identitas Anda dengan IDMark: https://idmark.faishal.id');
    return buffer.toString();
  }

  Future<void> _shareImage() async {
    setState(() => _isGenerating = true);
    try {
      final boundary = _repaintBoundaryKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return;

      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) return;
      final bytes = byteData.buffer.asUint8List();

      final filename = 'idmark_proof_${widget.config.purpose.replaceAll(' ', '_')}.png'
          .toLowerCase();

      if (kIsWeb) {
        downloadFileWeb(bytes, filename);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Sertifikat proteksi dokumen berhasil diunduh! 🛡️✨'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } else {
        // ignore: deprecated_member_use
        await Share.shareXFiles(
          [XFile.fromData(bytes, mimeType: 'image/png', name: filename)],
          text: _buildShareText(),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membagikan bukti: $e'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isGenerating = false);
    }
  }

  void _copyText() {
    Clipboard.setData(ClipboardData(text: _buildShareText()));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Bukti proteksi disalin ke clipboard! 📋✨'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = _themes[_selectedThemeIndex];
    final screenHeight = MediaQuery.of(context).size.height;
    final maxPreviewHeight = screenHeight * 0.48;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.bgSurface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 44,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade700,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // Header title
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.verified_user, color: AppColors.primaryLight, size: 20),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bukti Proteksi Dokumen',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Sertifikat integritas watermark & sensor sesuai Kominfo',
                        style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 20, color: Colors.white70),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Format & Theme Selectors
            Row(
              children: [
                Expanded(
                  child: SegmentedButton<bool>(
                    segments: const [
                      ButtonSegment(
                        value: false,
                        label: Text('Feed (4:5)', style: TextStyle(fontSize: 12)),
                        icon: Icon(Icons.crop_portrait, size: 16),
                      ),
                      ButtonSegment(
                        value: true,
                        label: Text('Story (9:16)', style: TextStyle(fontSize: 12)),
                        icon: Icon(Icons.stay_current_portrait, size: 16),
                      ),
                    ],
                    selected: {_isStoryFormat},
                    onSelectionChanged: (set) {
                      setState(() => _isStoryFormat = set.first);
                    },
                    style: ButtonStyle(
                      visualDensity: VisualDensity.compact,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Theme selector chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(_themes.length, (index) {
                  final t = _themes[index];
                  final isSelected = _selectedThemeIndex == index;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      selected: isSelected,
                      label: Text(t.name, style: TextStyle(fontSize: 12, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
                      avatar: CircleAvatar(
                        radius: 7,
                        backgroundColor: t.cardBg,
                      ),
                      onSelected: (_) {
                        setState(() => _selectedThemeIndex = index);
                      },
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 14),

            // Card Preview Area
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: maxPreviewHeight),
              child: Center(
                child: AspectRatio(
                  aspectRatio: _isStoryFormat ? (9 / 16) : (4 / 5),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: RepaintBoundary(
                      key: _repaintBoundaryKey,
                      child: _buildShareCard(theme),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Actions
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _copyText,
                    icon: const Icon(Icons.copy, size: 18, color: Colors.white),
                    label: const Text('Salin Teks', style: TextStyle(color: Colors.white)),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Color(0xFF334155)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton.icon(
                    onPressed: _isGenerating ? null : _shareImage,
                    icon: _isGenerating
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : Icon(kIsWeb ? Icons.download : Icons.share, size: 18),
                    label: Text(_isGenerating
                        ? 'Memproses...'
                        : (kIsWeb ? 'Unduh Bukti PNG' : 'Bagikan Bukti')),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.accentColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShareCard(IdmarkShareTheme theme) {
    final c = widget.config;
    final cardWidth = _isStoryFormat ? 360.0 : 380.0;
    final cardHeight = _isStoryFormat ? 640.0 : 475.0;

    return Container(
      width: cardWidth,
      height: cardHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: theme.bgGradient,
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 22,
        vertical: _isStoryFormat ? 32 : 22,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top pill
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.shield_outlined, size: 14, color: Colors.white),
                    const SizedBox(width: 6),
                    Text(
                      'IDMARK • SECURE ID',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                        color: theme.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: theme.badgeBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '100% ON-DEVICE',
                  style: TextStyle(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                    color: theme.badgeText,
                  ),
                ),
              ),
            ],
          ),

          if (_isStoryFormat) const Spacer() else const SizedBox(height: 14),

          // Central Certificate Pass
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.cardBg,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: theme.borderColor, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'BUKTI PROTEKSI WATERMARK DOKUMEN',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                        color: theme.textSecondary,
                      ),
                    ),
                    Icon(Icons.verified, size: 18, color: theme.accentColor),
                  ],
                ),
                const SizedBox(height: 14),

                // Purpose
                Text(
                  'UNTUK KEPERLUAN KHUSUS:',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                    color: theme.textSecondary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  c.purpose.toUpperCase(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.3,
                    color: theme.textPrimary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 14),

                // Key metrics box
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.badgeBg,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text('SKOR PRIVASI', style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.bold, color: theme.badgeText)),
                          const SizedBox(height: 2),
                          Text('${c.privacyScore}/100', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: theme.textPrimary)),
                        ],
                      ),
                      Container(width: 1, height: 30, color: theme.borderColor.withValues(alpha: 0.5)),
                      Column(
                        children: [
                          Text('SENSOR', style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.bold, color: theme.badgeText)),
                          const SizedBox(height: 2),
                          Text('${c.redactions.length} Area', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: theme.textPrimary)),
                        ],
                      ),
                      Container(width: 1, height: 30, color: theme.borderColor.withValues(alpha: 0.5)),
                      Column(
                        children: [
                          Text('FORMAT', style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.bold, color: theme.badgeText)),
                          const SizedBox(height: 2),
                          Text(c.exportFormat.name.toUpperCase(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: theme.textPrimary)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // Date and Pattern
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tanggal: ${widget.dateLabel}', style: TextStyle(fontSize: 11, color: theme.textSecondary)),
                    Text('Pola: ${c.pattern.label}', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: theme.accentColor)),
                  ],
                ),
                const SizedBox(height: 8),
                Divider(color: theme.borderColor.withValues(alpha: 0.5), height: 1),
                const SizedBox(height: 8),

                // SHA-256 integrity hash
                Text(
                  'INTEGRITY HASH (SHA-256):',
                  style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.bold, letterSpacing: 0.6, color: theme.textSecondary),
                ),
                const SizedBox(height: 2),
                Text(
                  widget.sha256Hash,
                  style: TextStyle(
                    fontSize: 8.5,
                    fontFamily: 'monospace',
                    color: theme.accentColor,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          if (_isStoryFormat) const Spacer() else const SizedBox(height: 14),

          // Watermark footer
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.lock_rounded, size: 12, color: Colors.white.withValues(alpha: 0.7)),
                const SizedBox(width: 5),
                Text(
                  'idmark.faishal.id • Standar Watermark KTP Kominfo RI',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withValues(alpha: 0.7),
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
