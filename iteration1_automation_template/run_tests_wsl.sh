#!/usr/bin/env bash
# 在 WSL 里一键运行 iteration1 全部测试用例，并输出 Total 统计
cd "$(dirname "$0")"

p=0; f=0; e=0
for x in testcases/iteration1/*.json; do
  [ -f "$x" ] || continue
  echo "=== $(basename "$x") ==="
  out=$(./rich_test.exe "$x")
  echo "$out"
  case "$(printf '%s' "$out" | grep -oP '"result"\s*:\s*"\K[A-Z]+')" in
    PASS) p=$((p+1));;
    FAIL) f=$((f+1));;
    *) e=$((e+1));;
  esac
done

echo
echo "Total: PASS=$p FAIL=$f ERROR=$e"
