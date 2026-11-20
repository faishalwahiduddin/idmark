import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/ui/app_scroll.dart';
import '../../core/ui/tap_target.dart';
import '../../core/models/audit_log_entry.dart';
import '../../core/providers/app_providers.dart';
import '../../core/providers/timezone_provider.dart';
import '../../core/utils/app_timezone.dart';
import '../../l10n/app_localizations.dart';
import '../../core/theme/app_numeric.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final logs = ref.watch(auditLogsProvider);

    final filteredLogs = _searchQuery.isEmpty
        ? logs
        : logs.where((l) => l.purpose.toLowerCase().contains(_searchQuery.toLowerCase())).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.historyAndAuditLog),
        actions: [
          if (logs.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline, size: 20),
              tooltip: l10n.clearAllHistoryTooltip,
              onPressed: () => _confirmClearHistory(context),
            ),
        ],
      ),
      body: ListView(
        physics: AppScroll.physics,
        padding: AppScroll.pagePadding(context),
        children: [
          // Security Overview Banner (solid surface: readable either theme)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.bannerSurface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.accent.withValues(alpha: 0.12)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.verified_outlined, color: AppColors.accent, size: 24),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.localPrivacyAuditLog,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        l10n.localPrivacyAuditLogDesc(logs.length),
                        style: const TextStyle(fontSize: 12, color: Color(0xFFCBD5E1), height: 1.35),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Search Box if logs exist
          if (logs.isNotEmpty) ...[
            TextField(
              style: const TextStyle(color: Colors.white, fontSize: 14),
              decoration: InputDecoration(
                hintText: l10n.searchHistoryHint,
                hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                prefixIcon: const Icon(Icons.search, size: 18),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 16),
                        onPressed: () => setState(() => _searchQuery = ''),
                      )
                    : null,
                filled: true,
                fillColor: AppColors.bgSurface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
              ),
              onChanged: (val) => setState(() => _searchQuery = val),
            ),
            const SizedBox(height: 16),
          ],

          // History list or Empty State
          if (logs.isEmpty)
            _buildEmptyState(l10n)
          else if (filteredLogs.isEmpty)
            _buildNoSearchResultState(l10n)
          else
            ...filteredLogs.map((entry) => _buildAuditCard(context, entry, l10n)),
        ],
      ),
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.history_edu_outlined, size: 48, color: AppColors.primaryLight),
            ),
            const SizedBox(height: 20),
            Text(
              l10n.noWatermarkedDocsYet,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.title(context)),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.noWatermarkedDocsDesc,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: AppColors.muted(context), height: 1.4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoSearchResultState(AppLocalizations l10n) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Text(
          l10n.noHistoryFound,
          style: TextStyle(color: AppColors.muted(context), fontSize: 13),
        ),
      ),
    );
  }

  Widget _buildAuditCard(BuildContext context, AuditLogEntry entry, AppLocalizations l10n) {
    // Storage contract (§TZ): timestamp is a UTC instant; display projects it
    // into the selected zone (manual zone, or device zone while on Auto).
    final loc = ref.watch(timezoneLocationProvider);
    final z = AppTimeZone.toZoned(entry.timestamp, loc);
    final day = z.day.toString().padLeft(2, '0');
    final month = z.month.toString().padLeft(2, '0');
    final hour = z.hour.toString().padLeft(2, '0');
    final minute = z.minute.toString().padLeft(2, '0');
    final dateFormat = '$day-$month-${z.year}, $hour:$minute';
    final sizeKb = (entry.fileSizeBytes / 1024).toStringAsFixed(1);

    final meta = [
      '${entry.exportFormat} · $sizeKb KB',
      entry.pattern,
      if (entry.redactionsCount > 0) l10n.sensitiveSensorsCount(entry.redactionsCount),
      if (entry.metadataStripped) l10n.exifSanitized,
    ].join(' · ');
    final lowScore = entry.privacyScore < 80;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Dismissible(
        key: ValueKey('audit-${entry.id}'),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: AppColors.danger,
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Icon(Icons.delete_outline, color: Colors.white),
        ),
        onDismissed: (_) => _deleteEntry(entry),
        child: Card(
          margin: EdgeInsets.zero,
          color: AppColors.bgCard,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: BorderSide(color: AppColors.subtleBorder(context, alpha: 0.1)),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 4, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row 1: timestamp, one exception pill (low score), menu.
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 14, color: AppColors.slate400),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        dateFormat,
                        style: const TextStyle(fontSize: 12, color: AppColors.slate400, fontFeatures: AppNumeric.tabularFeatures),
                      ),
                    ),
                    if (lowScore)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.bgSurface,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: AppColors.warning),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.warning_amber, size: 12, color: AppColors.warning),
                            const SizedBox(width: 4),
                            Text(
                              l10n.scoreLabel(entry.privacyScore),
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontFeatures: AppNumeric.tabularFeatures,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    PopupMenuButton<String>(
                      tooltip: l10n.deleteEntry,
                      icon: const Icon(Icons.more_vert, size: 20, color: AppColors.slate400),
                      color: AppColors.bgSurface,
                      onSelected: (_) => _deleteEntry(entry),
                      itemBuilder: (_) => [
                        PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              const Icon(Icons.delete_outline, size: 18, color: AppColors.danger),
                              const SizedBox(width: 10),
                              Text(l10n.deleteEntry, style: const TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row 2: purpose (the content), then one line of meta.
                      Text(
                        entry.purpose,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontFamily: 'monospace',
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        meta,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.slate400,
                              fontFeatures: AppNumeric.tabularFeatures,
                            ),
                      ),
                      const SizedBox(height: 10),

                      // Row 3: SHA-256 checksum
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          color: AppColors.bgDark,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            const Text(
                              'SHA-256: ',
                              style: TextStyle(fontSize: 10, color: AppColors.slate400, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: Text(
                                entry.sha256Hash.length > 24
                                    ? '${entry.sha256Hash.substring(0, 16)}...${entry.sha256Hash.substring(entry.sha256Hash.length - 8)}'
                                    : entry.sha256Hash,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'monospace',
                                  color: AppColors.slate400,
                                ),
                              ),
                            ),
                            // §A11Y: 14dp glyph needs an explicit 44dp hit area.
                            TapTarget(
                              minSize: 44,
                              semanticLabel: l10n.sha256Copied,
                              onTap: () {
                                Clipboard.setData(ClipboardData(text: entry.sha256Hash));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(l10n.sha256Copied),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                              child: const Icon(Icons.copy, size: 14, color: AppColors.primaryLight),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Deletes one entry with an Undo snackbar (restores it in place).
  Future<void> _deleteEntry(AuditLogEntry entry) async {
    final l10n = AppLocalizations.of(context)!;
    final messenger = ScaffoldMessenger.of(context);
    final notifier = ref.read(auditLogsProvider.notifier);
    final removed = await notifier.deleteEntry(entry.id);
    if (removed == null) return;
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text(l10n.historyEntryDeleted),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: l10n.undo,
          onPressed: () => notifier.restoreEntry(removed.$1, removed.$2),
        ),
      ),
    );
  }

  void _confirmClearHistory(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.bgSurface,
        title: Text(l10n.clearHistoryConfirmTitle, style: const TextStyle(color: Colors.white)),
        content: Text(
          l10n.clearHistoryConfirmBody,
          style: const TextStyle(color: Color(0xFF94A3B8)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(auditLogsProvider.notifier).clearHistory();
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.historyClearedSuccess)),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.danger),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
  }
}
