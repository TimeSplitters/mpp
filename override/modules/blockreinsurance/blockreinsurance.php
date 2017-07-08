<?php
if (!defined('_CAN_LOAD_FILES_'))
    exit;

class BlockreinsuranceOverride extends Blockreinsurance {
    public function hookFooter($params)
    {
        $this->context->controller->addCSS(($this->_path).'blockreinsurance.css', 'all');
        if (!$this->isCached('blockreinsurance.tpl', $this->getCacheId()))
        {
            //$infos = $this->getListContent($this->context->language->id);
            //$this->context->smarty->assign(array('infos' => $infos));
        }
        return $this->display(__FILE__, 'blockreinsurance.tpl', $this->getCacheId());
    }
}