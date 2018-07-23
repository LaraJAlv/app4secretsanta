<?php

namespace App\Mail;

use Illuminate\Mail\Mailable;

class SorteioMail extends Mailable
{
    private $nome;
    private $amigo;
    private $grupo;
    private $imagem;

    public function __construct(string $nome, string $grupo, string $amigo, string $imagem)
    {
        $this->nome = $nome;
        $this->grupo = $grupo;
        $this->amigo = $amigo;
        $this->imagem = $imagem;
    }

    public function build()
    {
        return $this->view('SorteioMail')->with([
                        'nome' => $this->nome,
                        'grupo' => $this->grupo,
                        'amigo' => $this->amigo,
                        'imagem' => $this->imagem,
                    ]);;
    }
}