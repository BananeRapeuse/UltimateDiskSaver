import paramiko
import os
import shutil

def backup_to_sftp(info):
    try:
        transport = paramiko.Transport((info['server'], 22))
        transport.connect(username=info['username'], password=info['password'])

        sftp = paramiko.SFTPClient.from_transport(transport)
        upload_dir(info['local_path'], info['remote_path'], sftp)

        sftp.close()
        transport.close()
        return True
    except Exception as e:
        print(f"An error occurred: {e}")
        return False

def upload_dir(local_dir, remote_dir, sftp):
    if not remote_dir.endswith('/'):
        remote_dir += '/'
    if not local_dir.endswith('/'):
        local_dir += '/'

    os.chdir(os.path.split(local_dir)[0])
    parent = os.path.split(local_dir)[1]

    for walker in os.walk(parent):
        try:
            sftp.mkdir(remote_dir + walker[0])
        except:
            pass
        for file in walker[2]:
            sftp.put(walker[0] + '/' + file, remote_dir + walker[0] + '/' + file)
