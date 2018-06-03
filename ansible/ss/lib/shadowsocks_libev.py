#!/usr/bin/python

from random import randrange
import secrets
import json
import string


ANSIBLE_METADATA = {
    'metadata_version': '1.1',
    'status': ['preview'],
    'supported_by': 'community'
}

DOCUMENTATION = '''
---
module: shadowsocks_libev

short_description: create shadowsocks-libev configs

version_added: "2.4"

description:
    - create shadowsocks-libev configs (server and client)

options:
    server:
        description:
            - server ip
        required: true
    name:
        description:
            - config file name (same for both remote and local)
        required: true
    port:
        description:
            - server port to use
        required: true
    local_port:
        description:
            - local port
        required: false
        default: (random)
    password:
        description:
            - the password to use, omit to generate one
        required: false
        default: (generate)
    timeout:
        description:
            - timeout value
        required: false
        default: 600
    method:
        description:
            - encryption method (AEAD)
        required: false
        default: chacha20-ietf-poly1305
    fast_open:
        description:
            - whether to use fast_open
        required: false
        default: True
    one_time:
        description:
            - whether to use one_time
        required: false
        default: True


author:
    - Xiangyu Zhu(@adv_zxy)
'''

EXAMPLES = '''
# good enough default config
- name: generate default configs
  shadowsocks_libev:
    server:
        - "107.191.45.80"
    name: aws
    port: 6789

'''

RETURN = '''
status:
    description: whether success
    type: bool
'''

from ansible.module_utils.basic import AnsibleModule


def gen_pw(l):
    alphabet = string.ascii_letters + string.digits + string.punctuation
    alphabet = list(filter(lambda x: x not in "\"'\\", alphabet))
    return ''.join(secrets.choice(alphabet) for _ in range(l))


def gen_local(para):
    data = {}
    for k, v in para.items():
        if k == 'name' or k == 'server':
            continue
        elif k == "port":
            data["server_port"] = v
        else:
            data[k] = v
    data["local_adderss"] = "127.0.0.1"
    if len(para['server']) == 1:
        data['server'] = para['server'][0]
        with open(f"{para['name']}-local.json", 'w') as f:
            f.write(json.dumps(data, indent=0, sort_keys=True))
    else:
        for i, s in enumerate(para['server']):
            data['server'] = s
            with open(f"{para['name']}{i}-local.json", 'w') as f:
                f.write(json.dumps(data, indent=0, sort_keys=True))
                print(json.dumps(data, indent=0, sort_keys=True))


def gen_server(para):
    data = {}
    for k, v in para.items():
        if k == 'name' or k == 'server':
            continue
        elif k == "port":
            data["server_port"] = v
        else:
            data[k] = v
    data['server'] = ["::0", "0.0.0.0"]
    #  data['local_port'] = randrange(4000, 65500)
    data.pop('local_port')
    with open(f"{para['name']}-server.json", 'w') as f:
        f.write(json.dumps(data, indent=0, sort_keys=True))


def run_module():
    # define the available arguments/parameters that a user can pass to
    # the module
    module_args = dict(
        server=dict(type='list', required=True),
        name=dict(type='str', required=True),
        port=dict(type='int', required=True),
        local_port=dict(type='int', required=False),
        password=dict(type='str', required=False, no_log=True),
        timeout=dict(type='int', required=False, default=600),
        method=dict(type='str', required=False, default='chacha20-ietf-poly1305'),
        fast_open=dict(type='bool', required=False, default=True),
        one_time=dict(type='bool', required=False, default=True),

    )

    # seed the result dict in the object
    # we primarily care about changed and state
    # change is if this module effectively modified the target
    # state will include any data that you want your module to pass back
    # for consumption, for example, in a subsequent task
    result = dict(
        changed=False,
        status=None
    )

    # the AnsibleModule object will be our abstraction working with Ansible
    # this includes instantiation, a couple of common attr would be the
    # args/params passed to the execution, as well as if the module
    # supports check mode
    module = AnsibleModule(
        argument_spec=module_args,
        supports_check_mode=True
    )

    if module.params['local_port'] is None:
        module.params['local_port'] = randrange(4000, 65500)
        print(f"local port: {module.params['local_port']}")
    if module.params['password'] is None:
        module.params['password'] = gen_pw(32)

    gen_local(module.params)
    gen_server(module.params)


    # if the user is working with this module in only check mode we do not
    # want to make any changes to the environment, just return the current
    # state with no modifications
    if module.check_mode:
        return result

    # during the execution of the module, if there is an exception or a
    # conditional state that effectively causes a failure, run
    # AnsibleModule.fail_json() to pass in the message and the result
    if module.params['name'] == 'fail me':
        module.fail_json(msg='You requested this to fail', **result)

    # in the event of a successful module execution, you will want to
    # simple AnsibleModule.exit_json(), passing the key/value results
    module.exit_json(**result)

def main():
    run_module()

if __name__ == '__main__':
    main()
