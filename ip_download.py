import os
import requests
import zipfile

def download_file(url, save_path):
    try:
        response = requests.get(url)
        if response.status_code == 200:
            filename = url.split("/")[-1]
            with open(save_path, "wb") as file:
                file.write(response.content)
            print(f"Downloaded {filename} and saved as {save_path}")
            return True
        else:
            print("Failed to download file (HTTP status code:", response.status_code, ")")
    except Exception as e:
        print("An error occurred:", e)
    return False

def unzip_file(zip_path, extract_folder):
    with zipfile.ZipFile(zip_path, 'r') as zip_ref:
        zip_ref.extractall(extract_folder)
        print("Extracted files to:", extract_folder)

def merge_ip_files():
    ip_files = []
    for file_name in os.listdir():
        if file_name.endswith('.txt') and len(file_name.split('-')) == 3:
            ip_files.append(file_name)

    unique_ips = set()
    with open('merge-ip.txt', 'w') as ip_output:
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
            # os.remove(ip_file)  # Delete the original txt file

if __name__ == "__main__":
    url = "https://zip.baipiao.eu.org"  # 修改为你需要下载的压缩文件的 URL
    save_path = os.path.join(os.path.dirname(__file__), "downloaded_file.zip")  # 修改保存路径和文件名
    extract_folder = os.path.dirname(__file__)  # 解压缩文件的目标文件夹为当前脚本所在文件夹

    print("Downloading from:", url)
    if download_file(url, save_path):
        unzip_file(save_path, extract_folder)
        os.remove(save_path)  # 删除下载的压缩文件
        merge_ip_files()

