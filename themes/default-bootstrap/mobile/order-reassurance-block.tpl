{if isset($smarty.get.step) && $smarty.get.step == 1}
    <div id="order-details-reinsurance-blocks">
        <div class="row gutter-10">
            <div class="col-xs-6 col-sm-6">
                <h3>{l s='Quality & Design'}</h3>
                <div>{l s='We only sell what we love & we are addicts of good quality!'}</div>
            </div>
            <div class="col-xs-6 col-sm-6">
                <h3>{l s='Be safe'}</h3>
                <div>{l s='Secured connection and payment – your information is safe.'}</div>
            </div>
        </div>
        <div class="row gutter-10">
            <div class="col-xs-6 col-sm-6">
                <h3>{l s='Real time monitoring'}</h3>
                <div>{l s='Follow in real time your order from your customer area.'}</div>
            </div>
            <div class="col-xs-6 col-sm-6">
                <h3>{l s='Love it or don\'t'}</h3>
                <div>{l s='We know that buying furniture online can be tricky – if you don\'t like it, we take it back.'}</div>
            </div>
        </div>
    </div>
{else}
    <div id="order-details-reinsurance-blocks" class="row gutter-10">
        <div class="row gutter-10">
            <div class="col-xs-6 col-sm-6">
                <h3>{l s='Quality & Design'}</h3>
                <div>{l s='We only sell what we love & we are addicts of good quality!'}</div>
                <div class="text-center">
                    <a class="text-uppercase" href="{$link->getCMSLink(12, 'le-concept-nv-gallery')|escape:'html':'UTF-8'}">{l s='Our concept'} > </a>
                </div>
            </div>
            <div class="col-xs-6 col-sm-6">
                <h3>{l s='Love it or don\'t'}</h3>
                <div>{l s='We know that buying furniture online can be tricky – if you don\'t like it, we take it back.'}</div>
                <div class="text-center">
                    <a class="text-uppercase" href="{$link->getCMSLink(14, 'retours-remboursements')|escape:'html':'UTF-8'}">{l s='Return policy'} > </a>
                </div>
            </div>
        </div>
        <div class="row gutter-10">
            <div class="col-xs-6 col-sm-6">
                <h3>{l s='We\'re here for you'}</h3>
                <div>
                    <div class="text-center">
                        {l s='Une question? Un doute? Contactez-nous: '} <br/>
                        <a href="tel:{Configuration::get('PS_SHOP_PHONE')}">{Configuration::get('PS_SHOP_PHONE')}</a>
                        <br/>
                    {l s='By email: '}
                        <br/>
                        <a href="{$link->getPageLink('contact', true)|escape:'html':'UTF-8'}">hello@monpotpourri.com</a>
                    </div>
                </div>
            </div>
            <div class="col-xs-6 col-sm-6">
                <h3>{l s='Be safe'}</h3>
                <div>{l s='Secured connection and payment – your information is safe.'}</div>
                <div class="text-center">
                    <a class="text-uppercase" href="{$link->getCMSLink(16, 'moyens-de-paiement')|escape:'html':'UTF-8'}">{l s='Payment methods'} > </a>
                </div>
            </div>
        </div>
    </div>
{/if}