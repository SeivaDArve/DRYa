#!/bin/bash
Lh=$(echo -e "\nNotas:\n - Escolhe desta lista uma LETRA para imprimir no prompt\n - Abrir este menu: \`Ctrl-X\` \n - A seta [BAIXO] navega para o final da lista \n - Esta lista serve para teclados desconfigurados ou teclas INOP\n ")
L0='DRYa: Emergency Keyboard: [ENTER] para colar uma letra: '
CHOICE=$(printf "a\nb\nc\nd\ne\nf\ng\nh\ni\nj\nk\nl\nm\nn\no\np\nq\nr\ns\nt\nu\nv\nw\nx\ny\nz\n \nA\nB\nC\nD\nE\nF\nG\nH\nI\nJ\nK\nL\nM\nN\nO\nP\nQ\nR\nS\nT\nU\nV\nW\nX\nY\nZ\n \n1\n2\n3\n4\n5\n6\n7\n8\n9\n0\n \n/\n\\ \n|\n!\\n?\n^\n@\n(\n)\n[\n]\n{\n}\n=\n&\n$\n*\n+\n\"\n'\n-\n_\n.\n:\n,\n;\n~ " | fzf --no-info --cycle --header="$Lh" --prompt="$L0")
echo -n "$CHOICE"
