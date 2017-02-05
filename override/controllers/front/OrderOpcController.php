<?php

class OrderOpcController extends OrderOpcControllerCore {
    public function init()
    {
        parent::init();

        if(isset($this->context->cookie->product_choice_book_surprise)) {
            $this->context->smarty->assign('product_choice_book_surprise', json_decode($this->context->cookie->product_choice_book_surprise));
        }
    }
}