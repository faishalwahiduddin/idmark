// IDMark — midnight slate with cyber cyan watermark security guilloche curves
(function () {
  const CYAN = '#38BDF8';
  let guilloche = '';
  for (let i = 0; i < 5; i++) {
    const yOff = 1350 + i * 40;
    guilloche += '<path d="M-60,' + yOff + ' Q1080,' + (yOff - 120) + ' 2160,' + (yOff + 80) + ' T4400,' + yOff + '" fill="none" stroke="' + CYAN + '" stroke-width="2.5" opacity="' + (0.15 + i * 0.08) + '"/>';
  }
  window.STORE_ART = {
    generic: false,
    theme: { bg: 'linear-gradient(160deg, #0F172A 0%, #020617 60%, #000000 100%)', ink: '#FFFFFF' },
    panoramaSvg:
      '<svg viewBox="0 0 4320 1920" preserveAspectRatio="xMidYMid slice" xmlns="http://www.w3.org/2000/svg">' +
        guilloche +
      '</svg>',
    rtlReverse: true
  };
})();
