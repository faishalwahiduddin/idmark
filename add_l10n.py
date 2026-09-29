import json, sys

def add_key(file_path, key, value):
    with open(file_path, 'r', encoding='utf-8') as f:
        data = json.load(f)
    data[key] = value
    with open(file_path, 'w', encoding='utf-8') as f:
        json.dump(data, f, ensure_ascii=False, indent=2)
        f.write('\n')

add_key('lib/l10n/app_id.arb', sys.argv[1], sys.argv[2])
add_key('lib/l10n/app_en.arb', sys.argv[1], sys.argv[3])
add_key('lib/l10n/app_ar.arb', sys.argv[1], sys.argv[4])
add_key('lib/l10n/app_jv.arb', sys.argv[1], sys.argv[5])
add_key('lib/l10n/app_su.arb', sys.argv[1], sys.argv[6])
add_key('lib/l10n/app_zh.arb', sys.argv[1], sys.argv[7])
add_key('lib/l10n/app_ja.arb', sys.argv[1], sys.argv[8])
add_key('lib/l10n/app_es.arb', sys.argv[1], sys.argv[9])
