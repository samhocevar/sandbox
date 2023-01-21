#!/usr/bin/env python

from oathtool import generate_otp
from re import sub
from sys import argv
from time import sleep

def expand(s: str) -> str:
    from pathlib import Path
    return str(Path(s).expanduser())

def read_lines(file: str) -> list[str]:
    with open(file, 'r') as f:
        return list(map(str.strip, f.readlines()))

def write_lines(file: str, data: list[str]):
    from os import replace
    with open(f'{file}.tmp', 'w') as f:
        f.writelines(f'{l}\n' for l in data)
    replace(f'{file}.tmp', file)

if len(argv) != 3:
    print(f'Usage: {argv[0]} <totp_file> <cred_file>')
    exit(1)

totp_secret_file = expand(argv[1])
vpn_cred_file = expand(argv[2])

totp_secret: str = read_lines(totp_secret_file)[0].strip()
otp: str = '000000'

while True:
    new_otp: str = generate_otp(totp_secret)
    if new_otp == otp:
        sleep(5)
        continue
    try:
        data: str = read_lines(vpn_cred_file)
        data[1] = sub('[0-9]{6}$', '', data[1]) + new_otp
        write_lines(vpn_cred_file, data)
        otp = new_otp
    except:
        # There are many reasons this could fail, one being that
        # the destination file is already opened for reading. Just
        # try again in one second.
        sleep(1)
