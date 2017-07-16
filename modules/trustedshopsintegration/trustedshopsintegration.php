<?php
/**
* 2007-2017 PrestaShop.
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author    PrestaShop SA <contact@prestashop.com>
*  @copyright 2007-2017 PrestaShop SA
*  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*/

require_once 'classes/tsid.php';
if (!defined('_PS_VERSION_')) {
    exit;
}

class TrustedShopsIntegration extends Module
{
    protected $config_form = false;

    private $variants = array();
    private $errors = array();
    private $locale = array();

    public function __construct()
    {
        $this->name = 'trustedshopsintegration';
        $this->tab = 'front_office_features';
        $this->version = '1.0.2';
        $this->author = 'Trusted Shops GmbH';
        $this->need_instance = 0;
        $this->module_key = 'c76df2ef7f4bb33432eea49dd8d0e3b5';

        $this->bootstrap = true;

        parent::__construct();

        $this->displayName = $this->l('Trusted Shops Reviews Toolkit');
        $this->description = $this->l('This module integrates Trusted Shops into your Prestashop installation.');

        $this->confirmUninstall = $this->l('Are you sure you want to uninstall this module?');

        $this->ps_versions_compliancy = array('min' => '1.6', 'max' => _PS_VERSION_);

        if (Configuration::get('PS_SSL_ENABLED') == 1) {
            $this->shopPath = _PS_BASE_URL_SSL_;
        } else {
            $this->shopPath = _PS_BASE_URL_;
        }
        // Error array
        $this->errors = array();
        // Module general data
        $this->setModuleData();
    }

    /**
     * Sets the relevant module data
     */
    private function setModuleData()
    {
        // Error reporting
        $this->errorMessages = array(
            'duplicate_entry' => $this->l('You can\'t add the same ID twice.')
        );

        // Possible lang 2 country combinations
        $possibleLocaleValues = array(
            'de' => 'DE',
            'en' => 'GB',
            'gb' => 'GB',
            'fr' => 'FR',
            'nl' => 'NL',
            'es' => 'ES',
            'it' => 'IT',
            'pl' => 'PL',
        );
        // Get locale key for product sticker js
        $this->local = $this->context->language->iso_code.'_'.$possibleLocaleValues[$this->context->language->iso_code];

        $this->defaultValues = array(
            'review_tab_border_color' => '#0DBEDC',
            'review_tab_background_color' => '#FFFFFF',
            'rating_star_color' => '#FFDC0F',
            'review_tab_star_color' => '#FFDC0F',
            'rating_star_size' => '14',
            'rating_font_size' => '12',
            'variant' => 'reviews'
        );

        /*
         * Variants and their translation
         */
        $this->variants = array(
            'default' => $this->l('Display Trustbadge without review stars'),
            'reviews' => $this->l('Display Trustbadge with review stars'),
            'hide' => $this->l('Hide Trustbadge'),
        );

        /*
         * Basic field translations
         */
        $this->fieldTranslations = array(
            'info_tab_1' => $this->l('Trusted Shops Integration'),
            'info_tab_2' => $this->l('Configure the Trustbadge for your shop'),
            'info_tab_3' => $this->l('Configure Product Reviews for your shop'),
            'id_trusted_shops' => $this->l('Trusted Shops ID'),
            'current_mode' => $this->l('Mode'),
            'variant' => $this->l('Variant'),
            'y_offset' => $this->l('Y-Offset'),
            'collect_reviews' => $this->l('Collect Product Reviews'),
            'show_reviews' => $this->l('Show Product Reviews on Product Detail page in a new tab'),
            'show_rating' => $this->l('Show Star Ratings on Product Detail Page below your Product Name'),
            'review_tab_name' => $this->l('Name of Product Reviews Tab'),
            'review_tab_border_color' => $this->l('Border color'),
            'review_tab_star_color' => $this->l('Star color'),
            'review_tab_background_color' => $this->l('Background color'),
            'hide_empty_reviews' => $this->l('Hide Product Review part, if empty'),
            'rating_star_color' => $this->l('Star color'),
            'rating_star_size' => $this->l('Star size'),
            'rating_font_size' => $this->l('Font size'),
            'hide_empty_ratings' => $this->l('Hide empty Star Ratings'),
            'trustbadge_code' => $this->l('Current Trustbadge Code'),
            'product_sticker_code' => $this->l('Current Product Sticker Code'),
            'product_widget_code' => $this->l('Current Product Widget Code'),
            'need_help' => $this->l('Need help?'),
            'delete_alert' => $this->l('Are you sure you want to delete your Trusted Shops ID and the implementation of Trusted Shops for this instance?'),
            'current_mode_tooltip' => $this->l('Both Standard and Expert mode can be used to configure all Trusted Shops Products of this module. Technically savvy users can edit all variables of the code snippets of the Trusted Shops products in the expert mode and thus use profounder settings.'),
        );
        $this->productShoppingAttributes = array('gtin', 'mpn', 'brand');
    }

    /**
     * Saving related links to configuration and install database.
     */
    public function install()
    {
        // Trusted Shops TrustBadge options link
        Configuration::updateValue('TRUSTEDSHOPS_TRUSTBADGE_OPTIONS_LINK_DE', 'http://www.trustedshops.de/shopbetreiber/integration/trustbadge/trustbadge-custom/');
        Configuration::updateValue('TRUSTEDSHOPS_TRUSTBADGE_OPTIONS_LINK_EN', 'http://www.trustedshops.co.uk/support/trustbadge/trustbadge-custom/');
        Configuration::updateValue('TRUSTEDSHOPS_TRUSTBADGE_OPTIONS_LINK_FR', 'http://www.trustedshops.fr/support/trustbadge/trustbadge-custom/');
        Configuration::updateValue('TRUSTEDSHOPS_TRUSTBADGE_OPTIONS_LINK_PL', 'http://www.trustedshops.pl/handlowcy/integracja/trustbadge/trustbadge-custom/');

        // Trusted Shops product review information link
        Configuration::updateValue('TRUSTEDSHOPS_PRODUCT_REVIEW_INFORMATION_LINK_DE', 'http://www.trustedshops.de/shopbetreiber/integration/product-reviews/');
        Configuration::updateValue('TRUSTEDSHOPS_PRODUCT_REVIEW_INFORMATION_LINK_EN', 'http://www.trustedshops.co.uk/support/product-reviews/');
        Configuration::updateValue('TRUSTEDSHOPS_PRODUCT_REVIEW_INFORMATION_LINK_FR', 'http://www.trustedshops.fr/support/integrer-les-avis-produits/');
        Configuration::updateValue('TRUSTEDSHOPS_PRODUCT_REVIEW_INFORMATION_LINK_PL', ' http://www.trustedshops.pl/handlowcy/integracja/integracja-opinii-o-produktach');

        // Trusted Shops general information link
        Configuration::updateValue('TRUSTEDSHOPS_INFORMATION_LINK_DE', 'http://www.trustedshops.de/shopbetreiber/bestellen.html/?a_aid=546a2b2c79731&a_bid=0a270ca8');
        Configuration::updateValue('TRUSTEDSHOPS_INFORMATION_LINK_EN', 'http://business.trustedshops.co.uk/pricing/?a_aid=546a2b2c79731&a_bid=0a270ca8');
        Configuration::updateValue('TRUSTEDSHOPS_INFORMATION_LINK_FR', 'http://business.trustedshops.fr/tarifs/?a_aid=546a2b2c79731&a_bid=0a270ca8');
        Configuration::updateValue('TRUSTEDSHOPS_INFORMATION_LINK_PL', 'https://www.trustedshops.pl/handlowcy/zamowienie.html?a_aid=546a2b2c79731&a_bid=0a270ca8');

        // Trusted Shop Test Link
        Configuration::updateValue('TRUSTEDSHOPS_TEST_LINK', 'https://www.trustedshops.com/reviewsticker/preview');

        // General help link, replacable variables
        Configuration::updateValue('TRUSTEDSHOPS_HELP_LINK_DE', 'http://support.trustedshops.com/de/apps/prestashop?utm_source=shopsoftwarebackend&utm_medium=link&utm_term=de&utm_campaign=shopsoftware&utm_content=PRESTASHOP&shop_id={tsid}&backend_language={iso_lang}&shopsw=prestashop&shopsw_version={ps_version}&plugin_version={plugin_version}&context=trustbadge&Google_Analytics');
        Configuration::updateValue('TRUSTEDSHOPS_HELP_LINK_EN', 'http://support.trustedshops.com/en/apps/prestashop?utm_source=shopsoftwarebackend&utm_medium=link&utm_term=en&utm_campaign=shopsoftware&utm_content=PRESTASHOP&shop_id={tsid}&backend_language={iso_lang}&shopsw=prestashop&shopsw_version={ps_version}&plugin_version={plugin_version}&context=trustbadge&Google_Analytics');
        Configuration::updateValue('TRUSTEDSHOPS_HELP_LINK_FR', 'http://support.trustedshops.com/fr/apps/prestashop?utm_source=shopsoftwarebackend&utm_medium=link&utm_term=fr&utm_campaign=shopsoftware&utm_content=PRESTASHOP&shop_id={tsid}&backend_language={iso_lang}&shopsw=prestashop&shopsw_version={ps_version}&plugin_version={plugin_version}&context=trustbadge&Google_Analytics');
        Configuration::updateValue('TRUSTEDSHOPS_HELP_LINK_PL', 'http://support.trustedshops.com/pl/apps/prestashop?utm_source=shopsoftwarebackend&utm_medium=link&utm_term=pl&utm_campaign=shopsoftware&utm_content=PRESTASHOP&shop_id={tsid}&backend_language={iso_lang}&shopsw=prestashop&shopsw_version={ps_version}&plugin_version={plugin_version}&context=trustbadge&Google_Analytics');

        Configuration::updateValue('TRUSTEDSHOPS_IMAGE_ALLOCATION', ImageType::getFormatedName('large'));

        Configuration::updateValue('TRUSTEDSHOPS_GTIN_ALLOCATION', 'product_ean13');
        Configuration::updateValue('TRUSTEDSHOPS_BRAND_ALLOCATION', 'product_manufacturer_name');
        Configuration::updateValue('TRUSTEDSHOPS_MPN_ALLOCATION', 'product_upc');

        include dirname(__FILE__).'/sql/install.php';

        return parent::install() &&
            $this->registerHook('header') &&
            $this->registerHook('backOfficeHeader') &&
            $this->registerHook('displayFooter') &&
            $this->registerHook('displayProductButtons') &&
            $this->registerHook('displayProductTabContent') &&
            $this->registerHook('displayOrderConfirmation');
    }

    /**
     * Uninstalls the module
     * Delete config entries.
     */
    public function uninstall()
    {
        // Remove default trusted shops links and default product attribute allocations
        Configuration::deleteByName('TRUSTEDSHOPS_TRUSTBADGE_OPTIONS_LINK_DE');
        Configuration::deleteByName('TRUSTEDSHOPS_TRUSTBADGE_OPTIONS_LINK_EN');
        Configuration::deleteByName('TRUSTEDSHOPS_TRUSTBADGE_OPTIONS_LINK_FR');
        Configuration::deleteByName('TRUSTEDSHOPS_PRODUCT_REVIEW_INFORMATION_LINK_DE');
        Configuration::deleteByName('TRUSTEDSHOPS_PRODUCT_REVIEW_INFORMATION_LINK_EN');
        Configuration::deleteByName('TRUSTEDSHOPS_PRODUCT_REVIEW_INFORMATION_LINK_FR');
        Configuration::deleteByName('TRUSTEDSHOPS_INFORMATION_LINK_DE');
        Configuration::deleteByName('TRUSTEDSHOPS_INFORMATION_LINK_EN');
        Configuration::deleteByName('TRUSTEDSHOPS_HELP_LINK');
        Configuration::deleteByName('TRUSTEDSHOPS_IMAGE_ALLOCATION');
        Configuration::deleteByName('TRUSTEDSHOPS_GTIN_ALLOCATION');
        Configuration::deleteByName('TRUSTEDSHOPS_BRAND_ALLOCATION');
        Configuration::deleteByName('TRUSTEDSHOPS_MPN_ALLOCATION');

        include dirname(__FILE__).'/sql/uninstall.php';

        return parent::uninstall();
    }

     /**
      * Gets the general trusted shops help link.
      * @param string $tsid Trusted Shops ID
      * @return string URL
      */
     private function getGeneralHelpLink($tsid)
     {
         $lang_iso = $this->context->language->iso_code;

         if (!in_array($lang_iso, array('de', 'en', 'fr', 'pl'))) {
             $lang_iso = 'en';
         }
         $infoLink = Configuration::get('TRUSTEDSHOPS_HELP_LINK_'.Tools::strtoupper($lang_iso));
         $arrSearch = array('{tsid}', '{iso_lang}', '{ps_version}', '{plugin_version}');
         $arrReplace = array($tsid, $this->context->language->iso_code, Configuration::get('PS_INSTALL_VERSION'), $this->version);
         $infoLink = str_replace($arrSearch, $arrReplace, $infoLink);

         return $infoLink;
     }

    /**
     * Gets a choosen ts link.
     * @param string $type Linktype
     * @return string URL
     */
    private function getTSLink($type = 'information')
    {
        $typeArray = array('information', 'product_review_information', 'trustbadge_options');
        $lang_iso = $this->context->language->iso_code;

        if (!in_array($lang_iso, array('de', 'en', 'fr', 'pl'))) {
            $lang_iso = 'en';
        }
        if (in_array($type, $typeArray)) {
            $key = 'TRUSTEDSHOPS_'.Tools::strtoupper($type).'_LINK_'.Tools::strtoupper($lang_iso);
            return Configuration::get($key);
        } else {
            return false;
        }
    }

     /**
      * Loads the configuration form.
      * @return string Module Layout
      */
    public function getContent()
    {
        $actionURL = AdminController::$currentIndex.'&configure='.$this->name.'&token='.Tools::getAdminTokenLite('AdminModules');

        $this->context->smarty->assign('actionURL', $actionURL);
        $this->context->smarty->assign('module_dir', $this->_path);
        $output = '';

        // Triggers if a ts config was edited
        if (((bool) Tools::isSubmit('submitTSConfig') === true) || ((bool) Tools::isSubmit('submitTSConfigAndContinue') === true)) {
            // Get form inputs
            if (Tools::getValue('current_mode') == 'standard') {
                $form_inputs = $this->getConfigFormStandardInputs();
            } else {
                $form_inputs = $this->getConfigFormExpertInputs();
            }
            // validation
            if (false !== $this->validateConfigurationForm($form_inputs)) {
                $this->postProcess($form_inputs);
                $output .= $this->displayConfirmation($this->l('Configuration has been saved.'));
            }
        }
        // Confirmation on Redirect to overview page
        if (((bool) Tools::getIsset('es')) === true && Tools::getValue('es') == 1) {
            $output .= $this->displayConfirmation($this->l('Configuration has been saved.'));
        }

        // Triggers if a ts id is added
        if (((bool) Tools::isSubmit('addTSConfig')) === true) {
            $this->addTSConfig();
        }

         // Triggers delete ts id
        if (((bool) Tools::getIsset('deletetrustedshopsintegration_configs')) === true && $this->tsExists(Tools::getValue('id_ts_config'))) {
            $this->removeTSConfig();
            $output .= $this->displayConfirmation($this->l('Configuration has been deleted.'));
        }

        /* Display errors */
        if (!empty($this->errors)) {
            $this->smarty->assign('errors', $this->errors);
            $output .= $this->display(__FILE__, 'views/templates/admin/validation_result.tpl');
        }

        // Renders configuration form
        if (Tools::getIsset('id_ts_config') && $this->tsExists(Tools::getValue('id_ts_config')) && Tools::getIsset('updatetrustedshopsintegration_configs')) {
            $output .= $this->renderConfigurationForm();
        // Renders overview page
        } else {
            $this->context->smarty->assign('ts_config_list', $this->initTSConfigList());

            $this->context->smarty->assign('languages', $this->getPossibleLanguages());
            $this->context->smarty->assign('registration_link', $this->getTSLink('information'));
            $this->context->smarty->assign('module_dir', _MODULE_DIR_);

            $iso_code = $this->context->language->iso_code;
            if (!in_array($iso_code, array('de', 'en', 'fr', 'pl'))) {
                $iso_code = 'en';
            }

            $this->context->smarty->assign('iso_lang', $iso_code);
            $output .= $this->context->smarty->fetch($this->local_path.'views/templates/admin/overview_page.tpl');
        }

        return $output;
    }

    /**
     * Gets the available languages for a shop instance
     * @return mixed[] Array of choosable languages for linking a trusted shops id
     */
    private function getPossibleLanguages()
    {
        $existingLanguagesByShop = "SELECT id_lang FROM "._DB_PREFIX_."trustedshopsintegration WHERE id_shop = '".pSQL($this->context->shop->id)."'";
        $existingLanguagesByShop = Db::getInstance()->executeS($existingLanguagesByShop, true, false);
        $languages = Language::getLanguages();
        $i = 0;
        if (!empty($existingLanguagesByShop)) {
            $i = 0;
            // Remove languages where a trusted shops id is already linked
            foreach ($languages as $possibleLang) {
                $id_lang = $possibleLang['id_lang'];
                foreach ($existingLanguagesByShop as $existingLang) {
                    $id_lang_existing = $existingLang['id_lang'];
                    if ($id_lang == $id_lang_existing) {
                        unset($languages[$i]);
                    }
                }
                $i++;
            }
            $langs = array_values($languages);
        } else {
            $langs = $languages;
        }
        // Return a information if all languages are already set
        if (empty($langs)) {
            $langs[] = array('id_lang' => '', 'name' => $this->l('All languages are set.'));
        }
        return $langs;
    }

    /**
     * Add the CSS & JavaScript files you want to be loaded in the BO.
     */
    public function hookBackOfficeHeader()
    {
        if (Tools::getValue('configure') == $this->name) {
            $this->context->controller->addJquery();
            $this->context->controller->addJS($this->_path.'views/js/back.js');
            $this->context->controller->addCSS($this->_path.'views/css/back.css');
        }
    }
    /**
     * Hooks the header content
     * @param mixed[] $param Site Information
     * @return null
     */
    public function hookHeader($param)
    {
        $cssRequired = array(
            'product'
        );
        if (isset($this->context->controller->php_self) && in_array($this->context->controller->php_self, $cssRequired)) {
            $this->context->controller->addCSS($this->_path . 'views/css/front.css', 'all');
        }
    }

    /**
     * Renders the configuration form depending on each ts-id current_mode setting.
     * @return string Configuration Form
     */
    protected function renderConfigurationForm()
    {
        $output = '';
        // get the ts configuration for backend
        $tsconfig = $this->getTSConfig(true);
        // assign the help link
        $this->smarty->assign('help_link', $this->getGeneralHelpLink($tsconfig['id_trusted_shops']));

        $this->smarty->assign('token', Tools::getAdminTokenLite('AdminModules'));

        /* Additional product attributes */
        $this->smarty->assign('collect_reviews', $tsconfig['collect_reviews']);

        /* Add translations to forms */
        $this->smarty->assign('fieldtranslation', $this->fieldTranslations);

        // Get product attribute allocations
        $possibleAllocations = $this->getProductPossibleAllocations();

        // the current allocation values
        $allocationValues = array(
            'gtin_allocation' => $tsconfig['gtin_allocation'],
            'mpn_allocation' => $tsconfig['mpn_allocation'],
            'brand_allocation' => $tsconfig['brand_allocation'],
        );
        // possible allocation values
        $shoppingAllocations = array(
            'mpnAllocations' => $possibleAllocations,
            'brandAllocations' => $possibleAllocations,
            'gtinAllocations' => $possibleAllocations,
        );
        $this->context->smarty->assign($shoppingAllocations);
        $this->context->smarty->assign($allocationValues);

        $ts_info_hint = $this->display(__FILE__, 'views/templates/admin/ts_info_hint.tpl');
        $this->context->smarty->assign('ts_info_hint', $ts_info_hint);

        // the additional product attribute template, used for setting the allocations
        $additional_product_attributes = $this->display(__FILE__, 'views/templates/admin/additional_product_attributes.tpl');
        $this->smarty->assign('additional_product_attributes', $additional_product_attributes);

        // Switches url based
        /* EXPERT MODE */
        if ((Tools::getIsset('current_mode') && Tools::getValue('current_mode') == 'expert') || ($tsconfig['current_mode'] == 'expert' && Tools::getValue('current_mode') != 'standard')) {

            // Assign the latest code taken from standard mode or assign the code from database
            if ($tsconfig['current_mode'] == 'standard') {
                $this->smarty->assign($tsconfig);
                $this->smarty->assign('trustbadge_code', $this->getCurrentTSSettingsJSON('trustbadge'));
                $this->smarty->assign('product_widget_code', $this->getCurrentTSSettingsJSON('product_widget'));
                $this->smarty->assign('product_sticker_code', $this->getCurrentTSSettingsJSON('product_sticker'));
                $this->smarty->assign('current_mode', 'expert');
            } else {
                $this->smarty->assign($tsconfig);
            }

            // trustbadge options link
            $this->smarty->assign('trustbadge_options_link', $this->getTSLink('trustbadge_options'));
            // trustedshops test link
            $this->smarty->assign('trusted_test_link', Configuration::get('TRUSTEDSHOPS_TEST_LINK'));

            // product review information link
            $this->smarty->assign('product_review_information_link', $this->getTSLink('product_review_information'));

            $output .= $this->display(__FILE__, 'views/templates/admin/custom_form_expert.tpl');
        /* STANDARD MODE */
        } else {
            $this->smarty->assign('variants', $this->variants);
            $this->smarty->assign($tsconfig);
            $this->smarty->assign('current_mode', 'standard');

            $output .= $this->display(__FILE__, 'views/templates/admin/custom_form_standard.tpl');
        }

        return $output;
    }

    /**
     * Get input fields for the standard form
     * @return string[] standard configuration form fields
     */
    private function getConfigFormStandardInputs()
    {
        return array(
            'current_mode',
            'variant',
            'y_offset',
            'collect_reviews',
            'show_reviews',
            'show_rating',
            'review_tab_name',
            'review_tab_border_color',
            'review_tab_star_color',
            'review_tab_background_color',
            'hide_empty_reviews',
            'rating_star_color',
            'rating_star_size',
            'rating_font_size',
            'hide_empty_ratings',
            'id_trusted_shops',
            'mpn_allocation'
        );
    }

    /**
     * Get input fields for the expert form
     * @return string[] expert configuration form fields
     */
    private function getConfigFormExpertInputs()
    {
        return array(
            'current_mode',
            'review_tab_name',
            'collect_reviews',
            'show_reviews',
            'show_rating',
            'trustbadge_code',
            'product_sticker_code',
            'product_widget_code',
            'mpn_allocation',
        );
    }

    /**
     * Save form data to trusted shops configuration.
     * @param string[] $form_inputs Input Form Fields
     */
    private function postProcess($form_inputs)
    {
        // Init the config object
        $id_ts_config = pSQL(Tools::getValue('id_ts_config'));
        $tsconfig = new TSID($id_ts_config);
        foreach ($form_inputs as $key) {
            $tsconfig->$key = Tools::getValue($key);
        }
        try {
            $tsconfig->save();
            // Redirect to overview url with editsuccess(es=1)
            $redirectURLOverview = AdminController::$currentIndex.'&configure='.$this->name.'&es=1&token='.Tools::getAdminTokenLite('AdminModules');
            if ((bool)Tools::isSubmit('submitTSConfigAndContinue') === true) {
                // stay on site, no redirect
            } else {
                Tools::redirectAdmin($redirectURLOverview);
            }
        } catch (Exception $e) {
            $this->errors[] = $e->getMessage();
        }
    }

    /**
     * Validates the configuration form.
     * @param String[] $existingFields Form Input fields
     * @return bool Validation result
     */
    private function validateConfigurationForm($existingFields)
    {
        // Rules from the TS ID Config Object
        $rules = TSID::$definition;

        // Check every field for rule
        foreach ($rules['fields'] as $inputField => $rule) {
            if (!in_array($inputField, $existingFields)) {
                continue;
            }
            // the input value
            $ipValue = Tools::getValue($inputField);

            if ($rule['type'] == TSID::TYPE_INT) {
                if (!Validate::isInt($ipValue) && $ipValue != '') {
                    $this->errors[] = $this->error($inputField, TSID::TYPE_INT);
                }
            }
            if ($rule['type'] == TSID::TYPE_STRING || $rule['type'] == TSID::TYPE_HTML) {
                // Color in field name, check for hex color value
                if (strpos($inputField, 'color') !== false) {
                    if (!$this->isHexColor($ipValue)) {
                        $this->errors[] = $this->error($inputField, 'hex');
                        continue;
                    }
                }
                if (!Validate::isString($ipValue)) {
                    $this->errors[] = $this->error($inputField, TSID::TYPE_STRING);
                }
            }
            if (strpos($inputField, '_code') !== false) {
                $result = Tools::jsonDecode($this->getRealJSON($ipValue));
                if ($result === null) {
                    $this->errors[] = $this->error($inputField, 'json');
                }
            }
        }
        if (!empty($this->errors)) {
            return false;
        }
        return true;
    }

    /**
     * Translation for error reports
     * @param string $field input field name
     * @param int $expectedType expected type
     * @return string error message
     */
    private function error($field, $expectedType)
    {
        $strError = $this->fieldTranslations[$field].': ';
        if ($expectedType == TSID::TYPE_STRING) {
            $strError .= $this->l('Please enter a valid string.');
        }
        if ($expectedType == TSID::TYPE_INT) {
            $strError .= $this->l('Please enter a valid number.');
        }
        if ($expectedType == 'hex') {
            $strError .= $this->l('Please enter a valid hex color.');
        }
        if ($expectedType == 'json') {
            $strError .= $this->l('Please enter a valid JSON configuration.');
        }

        return $strError;
    }

    /**
     * Builds the json array for expert mode
     */
    private function buildTrustbadgeJSONArray($tsconfig)
    {
        return array(
            'customElementId' => '',
            'trustcardDirection' => '',
            'customBadgeWidth' => '',
            'disableResponsive' => '',
            'disableTrustbadge' => '',
            'variant' => $tsconfig['variant'],
            'yOffset' => $tsconfig['y_offset']
        );
    }

    private function buildProductStickerJSONArray($tsconfig)
    {
        return array(
            'variant'  => 'productreviews',
            'borderColor' => $tsconfig['review_tab_border_color'],
            'backgroundColor' => $tsconfig['review_tab_background_color'],
            'starColor' => $tsconfig['review_tab_star_color'],
            'starSize' => '15px',
            'richSnippets' => 'off',
            'ratingSummary' => 'false',
            'maxHeight' => '600px',
            'hideEmptySticker' => ($tsconfig['hide_empty_reviews'] == 1 ? 'true' : 'false'),
            'filter' => 'true',
            'introtext' => ''
        );
    }

    private function buildProductWidgetJSONArray($tsconfig)
    {
        return array(
            'starColor' => $tsconfig['rating_star_color'],
            'starSize' => $tsconfig['rating_star_size'].'px',
            'fontSize' => $tsconfig['rating_font_size'].'px',
            'showRating' => ($tsconfig['show_rating'] == 1 ? 'true' : 'false'),
            'scrollToReviews' => 'false',
            'enablePlaceholder' => ($tsconfig['hide_empty_ratings'] == 1 ? 'true' : 'false')
        );
    }

    private function getCurrentTSSettingsJSON($type)
    {
        if (!in_array($type, array('product_sticker', 'product_widget', 'trustbadge'))) {
            return false;
        }
        $tsconfig = $this->getTSConfig();

        if ($type == 'trustbadge') {
            $arrSettings = $this->buildTrustbadgeJSONArray($tsconfig);
        }
        if ($type == 'product_sticker') {
            $arrSettings = $this->buildProductStickerJSONArray($tsconfig);
        }
        if ($type == 'product_widget') {
            $arrSettings = $this->buildProductWidgetJSONArray($tsconfig);
        }

        $formatted = $this->prettyJSON(Tools::jsonEncode($arrSettings));
        $formatted = str_replace('"', "'", $formatted);
        return $formatted;
    }

    private function getRealJSON($json)
    {
        return str_replace("'", '"', $json);
    }

    /**
     * Returns the trustedshops config as associative array.
     * @param boolean $be Get Ts COnfig for backend or frontend?
     */
    private function getTSConfig($be = false)
    {
        if ($be === false) {
            $sql = 'SELECT * FROM '._DB_PREFIX_."trustedshopsintegration WHERE id_shop = '".pSQL($this->context->shop->id)."' AND id_lang = '".pSQL($this->context->language->id)."'";
        } else {
            $id_ts_config = pSQL(Tools::getValue('id_ts_config'));
            $sql = 'SELECT * FROM '._DB_PREFIX_."trustedshopsintegration WHERE id_ts_config = '".pSQL($id_ts_config)."'";
        }

        $result = Db::getInstance()->getRow($sql, false);
        if (!empty($result)) {
            // Set default values in case values are not set
            foreach ($result as $field => $value) {
                if (empty($value) && array_key_exists($field, $this->defaultValues)) {
                    $result[$field] = $this->defaultValues[$field];
                }
            }
            return $result;
        }
        return false;
    }

    /**
     * Creates a new TS Config object and redirect user to configuration page.
     * @return null
     */
    protected function addTSConfig()
    {
        $tsconfig = new TSID();
        $idTS = pSQL(trim(Tools::getValue('id_trusted_shops')));
        $idTS = preg_replace('/\s+/', '', $idTS);
        $tsconfig->id_trusted_shops = $idTS;
        $tsconfig->variant = $this->defaultValues['variant'];
        $tsconfig->current_mode = 'standard';
        $tsconfig->gtin_allocation = Configuration::get('TRUSTEDSHOPS_GTIN_ALLOCATION');
        $tsconfig->mpn_allocation = Configuration::get('TRUSTEDSHOPS_MPN_ALLOCATION');
        $tsconfig->brand_allocation = Configuration::get('TRUSTEDSHOPS_BRAND_ALLOCATION');
        $tsconfig->id_lang = pSQL(Tools::getValue('id_lang'));
        $tsconfig->id_shop = pSQL($this->context->shop->id);

        try {
            $tsconfig->save();
            // last id s
            $lastID = DB::getInstance()->Insert_ID();
            // Redirect to TSID Configuration
            $redirectURL = AdminController::$currentIndex.'&configure='.$this->name.'&token='.Tools::getAdminTokenLite('AdminModules').'&id_ts_config='.$lastID.'&updatetrustedshopsintegration_configs';
            Tools::redirectAdmin($redirectURL);
        } catch (Exception $e) {
            $exceptionMessage = $e->getMessage();
            if (strpos($exceptionMessage, 'Duplicate entry') !== false) {
                $explicitMessage = $this->errorMessages['duplicate_entry'];
            } else {
                $explicitMessage = $e->getMessage();
            }
            // Add errors to array
            $this->errors[] = $explicitMessage;
        }
    }

    /**
     * Removes a choosen TS config.
     * @return null
     */
    protected function removeTSConfig()
    {
        try {
            $tsconfig = new TSID(pSQL(Tools::getValue('id_ts_config')));
            $tsconfig->delete();
        } catch (Exception $e) {
            $this->errors = $e->getMessage();
        }

    }

    /**
     * Existing TS Config?
     * @param int $id_ts_config The Trusted Shops Config ID
     * @return bool TS ID existing
     */
    protected function tsExists($id_ts_config)
    {
        $existing = Db::getInstance()->getValue('SELECT id_ts_config FROM '._DB_PREFIX_."trustedshopsintegration WHERE id_ts_config = '".pSQL($id_ts_config)."'", false);
        if ($existing !== false) {
            return true;
        }

        return false;
    }

    /**
     * Inits TS Config overview list.
     * @return string HTML List Content
     */
    protected function initTSConfigList()
    {
        $this->fields_list = array(
            'id_ts_config' => array(
                'title' => $this->l('ID'),
            ),
            'id_trusted_shops' => array(
                'title' => $this->l('Trusted Shops ID'),
            ),
            'id_shop' => array(
                'title' => $this->l('Shop'),
            ),
            'id_lang' => array(
                'title' => $this->l('Language'),
            ),
            'variant' => array(
                'title' => $this->l('Variant'),
            ),
        );
        $helper = new HelperList();
        $helper->shopLinkType = '';
        $helper->simple_header = true;
        // Possible actions
        $helper->actions = array('edit', 'delete');
        $helper->identifier = 'id_ts_config';
        $helper->show_toolbar = true;
        $helper->title = $this->l('Manage your Trusted Shops IDs');
        $helper->table = $this->name.'_configs';
        $helper->token = Tools::getAdminTokenLite('AdminModules');
        $helper->currentIndex = AdminController::$currentIndex.'&configure='.$this->name;
        // get list content
        $content = $this->getListContent();
        // return the lists html
        return $helper->generateList($content, $this->fields_list);
    }

    /**
     * Gets ts config list content and translates the possible variants for displaying in Backend
     * @return mixed[] List content
     */
    protected function getListContent()
    {
        $result = Db::getInstance()->executeS('SELECT t.id_ts_config, t.id_trusted_shops, t.variant, t.current_mode, s.name AS id_shop, l.name AS id_lang
                                            FROM '._DB_PREFIX_.'trustedshopsintegration t INNER JOIN '._DB_PREFIX_.'lang l ON t.id_lang = l.id_lang
                                            LEFT JOIN '._DB_PREFIX_."shop s ON t.id_shop = s.id_shop
                                            WHERE t.id_shop = '".pSQL($this->context->shop->id)."'", true, false);
        if (!empty($result)) {
            $i = 0;
            foreach ($result as $row) {
                if ($row['current_mode'] == 'expert') {
                    $result[$i]['variant'] = $this->l('Expert Mode');
                } else {
                    $result[$i]['variant'] = $this->variants[$row['variant']];
                }
                ++$i;
            }
        }

        return $result;
    }

    /**
     * Hooks the footer content and adds the trustbadge js code.
     * @return string Trustbadge JS Template
     */
    public function hookDisplayFooter()
    {
        $tsconf = $this->getTSConfig();
        if (!empty($tsconf)) {
            $this->smarty->assign($tsconf);
            if ($tsconf['current_mode'] == 'expert') {
                // Expert mode
                $trustbadge_config = Tools::jsonDecode($this->getRealJSON($tsconf['trustbadge_code']), true);
                $this->smarty->assign('trustbadge_config', $trustbadge_config);
                return $this->display(__FILE__, 'views/templates/hook/trustbadge_js_expert.tpl');
            } else {
                // Standard mode
                return $this->display(__FILE__, 'views/templates/hook/trustbadge_js.tpl');
            }
        }
    }

    /**
     * Hooks the product buttons content and display product star rating.
     *
     * @param $params array page information
     */
    public function hookDisplayProductButtons($params)
    {
        $product_sku = $params['product']->reference;
        $tsconf = $this->getTSConfig();
        // Show Rating or the expert mode must be enabled
        if (!empty($tsconf) &&
            $tsconf['show_rating'] == 1 &&
            $tsconf['collect_reviews'] == 1) {
            // General assignments
            $this->smarty->assign($tsconf);
            $this->smarty->assign('ts_product_sku', $product_sku);

            if ($tsconf['current_mode'] == 'expert') {
                // Expert mode
                $this->smarty->assign('product_widget_config', Tools::jsonDecode($this->getRealJSON($tsconf['product_widget_code'])));
                return $this->display(__FILE__, 'views/templates/hook/product_widget_js_expert.tpl');
            } else {
                // standard mode
                return $this->display(__FILE__, 'views/templates/hook/product_widget_js.tpl');
            }
        }
    }

    /**
     * Hooks the Product Tab Content and displays product review
     * product_sticker_js.tpl.
     * @param mixed[] $params
     */
    public function hookDisplayProductTabContent($params)
    {
        $product_sku = $params['product']->reference;
        $tsconf = $this->getTSConfig();

        if (!empty($tsconf) &&
            $tsconf['show_reviews'] == 1 &&
            $tsconf['collect_reviews'] == 1) {
            // General assignments
            $this->context->smarty->assign($tsconf);
            $this->context->smarty->assign('ts_product_sku', $product_sku);
            $this->context->smarty->assign('locale', $this->local);

            if ($tsconf['current_mode'] == 'expert') {
                // Expert mode
                $product_sticker_config = Tools::jsonDecode($this->getRealJSON($tsconf['product_sticker_code']));
                $this->context->smarty->assign('product_sticker_config', $product_sticker_config);
                return $this->display(__FILE__, 'views/templates/hook/product_sticker_js_expert.tpl');
            } else {
                // Standard mode
                return $this->display(__FILE__, 'views/templates/hook/product_sticker_js.tpl');
            }
        }
    }

    /**
     * Hooks the order confirmation page and inserts order and product related
     * information to the checkout_trustcard, which will be recognized by the main trustcard js code.
     *
     * @param mixed[] $params information about the current order
     */
    public function hookDisplayOrderConfirmation($params)
    {
        $tsconfig = $this->getTSConfig();
        if (!empty($tsconfig)) {
            $id_currency = pSQL($params['objOrder']->id_currency);
            $currency = new Currency($id_currency);
            $orderDetails = array(
                'order_number' => $params['objOrder']->reference,
                'customer_email' => $this->context->customer->email,
                'order_amount' => Tools::ps_round($params['total_to_pay'], 2),
                'order_currency' => $currency->iso_code,
                'payment_method' => $params['objOrder']->payment,
                /* estimated delivery date is not supported in prestashop yet */
                'delivery_date' => '',
            );
            $orderProducts = $this->getOrderProductDetails($params['objOrder']->id, $tsconfig);
            $this->context->smarty->assign('collect_reviews', $tsconfig['collect_reviews']);
            $this->context->smarty->assign($orderDetails);
            $this->context->smarty->assign('products', $orderProducts);

            return $this->display(__FILE__, 'views/templates/hook/checkout_trustcard.tpl');
        }
    }

    /**
     * Gets order product details for the checkout trustcard.
     * @param int $id_order
     * @param mixed[] $tsconfig
     */
    private function getOrderProductDetails($id_order, $tsconfig)
    {
        $sql = 'SELECT * FROM '._DB_PREFIX_."order_detail WHERE id_order = '".pSQL($id_order)."'";
        $result = Db::getInstance()->executeS($sql, true, false);
        $image_type_default = Configuration::get('TRUSTEDSHOPS_IMAGE_ALLOCATION');
        $products = array();
        $i = 0;
        foreach ($result as $row) {
            $products[$i] = $row;
            $id_product = (int) pSQL($row['product_id']);
            $product = new Product($id_product);
            $product_link_rewrite = $product->link_rewrite[$this->context->language->id];
            $default_category_rewrite = Category::getLinkRewrite((int) $product->id_category_default, $this->context->language->id);
            $products[$i]['url'] = $this->context->link->getProductLink($product, null, $default_category_rewrite);
            /* Add image allocation */
            $coverImageID = (int) $this->getCoverImage($product->id);
            /* Image URL Location */
            $imageURL = $this->shopPath.'/'.$coverImageID.'-'.$image_type_default.'/'.$product_link_rewrite.'.jpg';

            $products[$i]['imageurl'] = $imageURL;
            // Removed GTIN Allocation / EAN-13 is GTIN
            // Get gtin from variant! //
            //$products[$i]['gtin'] = $this->getProductShoppingAttribute('gtin', $product, $tsconfig);
            $products[$i]['gtin'] = $row['product_ean13'];
            // Removed Brand Allocation / manufacturer_name = brand
            //$products[$i]['brand'] = $this->getProductShoppingAttribute('brand', $product, $tsconfig);
            $products[$i]['brand'] = Manufacturer::getNameById($product->id_manufacturer);
            // SKU = product_reference
            /* GET SKU FROM PARENT OBJECT */
            $products[$i]['sku'] = $product->reference;
            // MPN is not set in prestashop standard
            $products[$i]['mpn'] = $this->getProductShoppingAttribute('mpn', $product, $tsconfig);
            ++$i;
        }
        return $products;
    }

    /**
     * Gets the product cover image.
     * @param int $id_product Id of the product
     * @return int id_image
     */
    private function getCoverImage($id_product)
    {
        return Db::getInstance()->getValue('SELECT i.id_image
                                            FROM '._DB_PREFIX_.'image i
                                            INNER JOIN '._DB_PREFIX_.'image_lang il
                                             ON i.id_image = il.id_image
                                             LEFT JOIN '._DB_PREFIX_."image_shop ish
                                             ON i.id_image = ish.id_image WHERE
                                             i.id_product = '".pSQL($id_product)."' AND
                                             i.cover = '1' AND
                                             il.id_lang = '".pSQL($this->context->language->id)."' AND
                                             ish.id_shop = '".pSQL($this->context->shop->id)."'", false);
    }

    /**
     * Gets product features based on language and shop id.
     * @return mixed[] Features
     */
    private function getProductFeatures()
    {
        $featureSelect = 'SELECT fl.id_feature, fl.name
        FROM '._DB_PREFIX_.'feature_lang fl
        INNER JOIN '._DB_PREFIX_."feature_shop fs
        ON fl.id_feature = fs.id_feature
        WHERE
        fl.id_lang = '".pSQL($this->context->language->id)."' AND fs.id_shop = '".pSQL($this->context->shop->id)."'";

        return Db::getInstance()->executeS($featureSelect, true, false);
    }

    /**
     * Create select options for additonal product attributes section.
     * @return mixed[] array of possible allocations
     */
    private function getProductPossibleAllocations()
    {
        $features = $this->getProductFeatures();
        $possibleAllocations = array(
            'none' => $this->l('Non existent data'),
            //'product_ean13' => $this->l('Product property:').' EAN-13',
            //'product_reference' => $this->l('Product property:').' '.$this->l('Article No. / Reference'),
            //'product_manufacturer_name' => $this->l('Product property:').' '.$this->l('Manufacturer'),
            'product_upc' => $this->l('Product property:').' UPC',
        );
        foreach ($features as $productFeature) {
            $possibleAllocations['feature_'.$productFeature['id_feature']] = $this->l('Product feature:').' '.$productFeature['name'];
        }

        return $possibleAllocations;
    }


    /**
     * Gets a feature value.
     *
     * @param id_feature id of feature
     * @param id_product id of product
     */
    private function getFeature($id_feature, $id_product)
    {
        $featureSelect = "SELECT fvl.value
            FROM "._DB_PREFIX_."feature_value_lang fvl
            INNER JOIN "._DB_PREFIX_."feature_product fp
            ON fvl.id_feature_value = fp.id_feature_value
            WHERE fp.id_feature = '".pSQL($id_feature)."' AND fvl.id_lang = '".pSQL($this->context->language->id)."'
            AND fp.id_product = '".pSQL($id_product)."'";

        return Db::getInstance()->getValue($featureSelect, false);
    }

    /**
     * Gets a product shopping attribute which is needed for additional data analysis, google shopping and trusted shops checkout.
     *
     * used in getOrderProductDetails for getting the mpn
     * @param $type
     * @param $objProduct instance of product object
     */
    private function getProductShoppingAttribute($type, Product $objProduct, $tsconfig = array())
    {
        if (!in_array($type, $this->productShoppingAttributes)) {
            return false;
        }

        $configValue = $tsconfig[$type.'_allocation'];
        // Nothing selected
        if ($configValue == 'none') {
            return '';
        }
        $getType = explode('_', $configValue);
        // Product property
        if ($getType[0] == 'product') {
            // for example: product_ean13
            // Add atribute
            $property = str_replace('product_', '', $configValue);
            $result = $objProduct->$property;
        // Product feature
        } elseif ($getType[0] == 'feature') {
            // for example: feature_2, getType[1] is id_feature
            $id_feature = $getType[1];
            $result = $this->getFeature($id_feature, $objProduct->id);
        }

        if (isset($result)) {
            return $result;
        }

        return false;
    }

    /**
     * Is a value a valid hex color?
     *
     * @param $ip input value
     */
    private function isHexColor($ip)
    {
        if (preg_match('/^#[a-f0-9]{6}$/i', $ip) || $ip == '') {
            return true;
        }
        return false;
    }

    /**
     * Function taken from: http://snipplr.com/view/60559/prettyjson/
     * Pretty up json encoded data
     */
    private function prettyJSON($json)
    {
        $result      = '';
        $pos         = 0;
        $strLen      = Tools::strlen($json);
        $indentStr   = '  ';
        $newLine     = "\n";
        $prevChar    = '';
        $outOfQuotes = true;
        for ($i=0; $i<=$strLen; $i++) {
            // Grab the next character in the string.
            $char = Tools::substr($json, $i, 1);
            // Are we inside a quoted string?
            if ($char == '"' && $prevChar != '\\') {
                $outOfQuotes = !$outOfQuotes;

            // If this character is the end of an element,
            // output a new line and indent the next line.
            } else if (($char == '}' || $char == ']') && $outOfQuotes) {
                $result .= $newLine;
                $pos --;
                for ($j=0; $j<$pos; $j++) {
                    $result .= $indentStr;
                }
            }
            // Add the character to the result string.
            $result .= $char;
            // If the last character was the beginning of an element,
            // output a new line and indent the next line.
            if (($char == ',' || $char == '{' || $char == '[') && $outOfQuotes) {
                $result .= $newLine;
                if ($char == '{' || $char == '[') {
                    $pos ++;
                }

                for ($j = 0; $j < $pos; $j++) {
                    $result .= $indentStr;
                }
            }
            $prevChar = $char;
        }
        return $result;
    }
}
