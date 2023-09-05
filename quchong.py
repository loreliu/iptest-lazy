import os

def merge_ip_files():
    ip_files = []
    for file_name in os.listdir():
        if file_name.endswith('.txt') and len(file_name.split('-')) == 3:
            ip_files.append(file_name)

    unique_ips = set()
    with open('ip.txt', 'w') as ip_output:
        for ip_file in ip_files:
            ip_parts = ip_file.split('-')
            ip = ip_parts[0]
            port = ip_parts[2].split('.')[0]  # Remove .txt extension
            with open(ip_file, 'r') as ip_input:
                for line in ip_input:
                    line = line.strip()
                    if line:  # Skip empty lines
                        ip_port = f'{line}   {port}'
                        if ip_port not in unique_ips:
                            unique_ips.add(ip_port)
                            ip_output.write(f'{ip_port}\n')
            os.remove(ip_file)  # Delete the original txt file

if __name__ == '__main__':
    merge_ip_files()
