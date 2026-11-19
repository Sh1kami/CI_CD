#!/bin/sh
printf '%s\n' 'Введіть ім’я:'
if ! IFS= read -r name || [ -z "$name" ]; then
    printf '%s\n' 'Помилка: ім’я не може бути порожнім.' >&2
    exit 1
fi
printf '%s\n' 'Введіть вік:'
IFS= read -r age || exit 1
case "$age" in
    ''|*[!0-9]*) printf '%s\n' 'Помилка: вік має бути невід’ємним цілим.' >&2; exit 1 ;;
esac
while [ "${age#0}" != "$age" ]; do age=${age#0}; done
[ -n "$age" ] || age=0
if [ "${#age}" -gt 3 ] || [ "$age" -gt 150 ]; then
    printf '%s\n' 'Помилка: допустимий вік від 0 до 150.' >&2
    exit 1
fi
printf 'Привіт %s, через рік тобі буде %s років!\n' "$name" "$((age + 1))"
