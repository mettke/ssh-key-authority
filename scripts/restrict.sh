#!/bin/sh
set -- $SSH_ORIGINAL_COMMAND
cmd="$1"; shift;
case "$cmd" in
    /usr/bin/env) 
        case "${@}" in
            "test -d /var/local/keys-sync")
                /usr/bin/env test -d /var/local/keys-sync;
                exit $?;
                ;;
            "cat /var/local/keys-sync/.hostnames")
                /usr/bin/env cat /var/local/keys-sync/.hostnames;
                exit $?;
                ;;
            "hostname -f")
                /usr/bin/env hostname -f;
                exit $?;
                ;;
            "hostname -f")
                /usr/bin/env hostname -f;
                exit $?;
                ;;
            "sha1sum '/var/local/keys-sync'/*")
                /usr/bin/env sha1sum '/var/local/keys-sync'/*;
                exit $?;
                ;;
            "id "*)
                eval "${@}";
                exit $?;
                ;;
            "chmod 600 '/var/local/keys-sync/"*)
                eval "${@}";
                exit $?;
                ;;
            "chown keys-sync: '/var/local/keys-sync/"*)
                eval "${@}";
                exit $?;
                ;;
            "rm -f '/var/local/keys-sync/"*)
                eval "${@}";
                exit $?;
                ;;
            "cat /etc/uuid")
                /usr/bin/env cat /etc/uuid;
                exit $?;
                ;;
            *);;
        esac
        ;;
    scp)
        case "${1}" in
            "-t")
                case "${2}" in
                    "'/var/local/keys-sync/"*)
                        scp -t "$(echo ${2} | xargs)" < /dev/stdin;
                        exit $?;
                        ;;
                    *);;
                esac
                ;;
            *);;
        esac
        ;;
    *);;
esac
echo "${cmd} ${@}" >> /var/local/keys-sync/.exec.log;
exit 1;
