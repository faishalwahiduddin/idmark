const EXACT = {
  '/ar/blog/احم-نسخ-الهوية-عادات-آمنة-قبل-المشاركة/': '/ar/blog/ahm-nskh-alhwya-aadat-amna-qbl-almsharka/',
  '/ar/blog/ختم-الغرض-والتاريخ-حد-آمن-لمشاركة-الوثائق/': '/ar/blog/khtm-alghrd-waltarykh-hd-amn-lmsharka-alwthaiq/',
  '/ar/blog/علامة-e-ktp-آمنة-ختم-الغرض-والتاريخ-دون-إنترنت/': '/ar/blog/alama-e-ktp-amna-khtm-alghrd-waltarykh-dwn-intrnt/',
  '/en/blog/lindungi-fotokopi-ktp': '/en/blog/protect-ktp-copies-safe-habits-before-sharing/',
  '/en/blog/stamp-tujuan-tanggal-dokumen': '/en/blog/purpose-and-date-stamp-safe-limits-for-sharing/',
  '/en/blog/watermark-ektp-aman-offline': '/en/blog/secure-e-ktp-watermark-offline-purpose-and-date-stamp/',
  '/id/blog/lindungi-fotokopi-ktp/': '/id/blog/lindungi-fotokopi-ktp-kebiasaan-aman-sebelum-berbagi/',
  '/id/blog/stamp-tujuan-tanggal-dokumen/': '/id/blog/stamp-tujuan-dan-tanggal-batas-aman-berbagi-dokumen/',
  '/id/blog/watermark-ektp-aman-offline/': '/id/blog/watermark-e-ktp-aman-stamp-tujuan-dan-tanggal-offline/',
  '/ja/blog/安全な-e-ktp-透かしオフライン目的日付印/': '/ja/blog/anzen-na-e-suka-shi-ofurain-mokuteki-hizukein/',
  '/ja/blog/目的日付印書類共有の安全な境界/': '/ja/blog/mokuteki-hizukein-shorui-kyouyuu-no-anzen-na-kyoukai/',
  '/ja/blog/身分証コピーを守る共有前の安全な習慣/': '/ja/blog/mibun-shou-kopii-wo-mamoru-kyouyuu-mae-no-anzen-na-shuukan/',
  '/jv/blog/lindungi-fotokopi-ktp': '/jv/blog/lindungi-fotokopi-ktp-kebiasaan-aman-sadurunge-berbagi/',
  '/jv/blog/stamp-tujuan-tanggal-dokumen': '/jv/blog/stamp-tujuan-lan-tanggal-wates-aman-berbagi-dokumen/',
  '/jv/blog/watermark-ektp-aman-offline': '/jv/blog/watermark-e-ktp-aman-stamp-tujuan-lan-tanggal-offline/',
  '/su/blog/lindungi-fotokopi-ktp': '/su/blog/lindungan-fotokopi-ktp-kabiasaan-aman-samemeh-bagikeun/',
  '/su/blog/stamp-tujuan-tanggal-dokumen': '/su/blog/stamp-tujuan-jeung-tanggal-wates-aman-bagikeun-dokumen/',
  '/su/blog/watermark-ektp-aman-offline': '/su/blog/watermark-e-ktp-aman-stamp-tujuan-jeung-tanggal-offline/',
  '/zh/blog/保护身份证复印件分享前的安全习惯/': '/zh/blog/bao-hu-shen-fen-zheng-fu-yin-jian-fen-xiang-qian-de-an-quan-xi-guan/',
  '/zh/blog/安全的-e-ktp-水印离线盖用途与日期/': '/zh/blog/an-quan-de-e-shui-yin-li-xian-gai-yong-tu-yu-ri-qi/',
  '/zh/blog/用途与日期戳分享证件的安全边界/': '/zh/blog/yong-tu-yu-ri-qi-chuo-fen-xiang-zheng-jian-de-an-quan-bian-jie/'
};

const BLOG_PATH = /^\/(id|en|ar|zh|ja|jv|su)\/blog\/./;

export async function onRequest(context) {
  const url = new URL(context.request.url);
  const decoded = decodeURIComponent(url.pathname);
  const mapped = EXACT[decoded];
  if (mapped) return Response.redirect(url.origin + mapped, 301);

  const response = await context.next();
  if (response.status !== 404) return response;

  // Anything still unresolved under a blog path goes to its locale index rather
  // than a dead end.
  if (BLOG_PATH.test(decoded)) {
    const locale = decoded.split("/")[1];
    return Response.redirect(`${url.origin}/${locale}/blog/`, 301);
  }
  return response;
}
