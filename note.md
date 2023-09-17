# note

```bash
iptest_x64.exe -speedtest=0 -tls=true -outfile gcore_tls_result.csv -file ip2.txt -max 5
```

```bash
./iptest_linux_x64 -speedtest=0 -tls=true -outfile gcore_tls_result.csv -file ip2.txt -max 5
```

```bash
type gcore-1.csv >> merged.txt
type gcore-2.csv >> merged.txt
type gcore-3.csv >> merged.txt
type gcore-4.csv >> merged.txt
type gcore.csv >> merged.txt
```

```bash
type gcore_tls_result_0.csv >> gcore_tls_result.csv
type gcore_tls_result_1.csv >> gcore_tls_result.csv
type gcore_tls_result_2.csv >> gcore_tls_result.csv
type gcore_tls_result_3.csv >> gcore_tls_result.csv
type gcore_tls_result_4.csv >> gcore_tls_result.csv
```
