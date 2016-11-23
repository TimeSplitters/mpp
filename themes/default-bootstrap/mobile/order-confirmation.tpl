<div class="col-xs-12 col-sm-12">
    {capture name=path}{l s='Order confirmation'}{/capture}
    <div class="page-header">
        <div>
            <h3 class="text-uppercase">{l s='Order confirmation'}</h3>
        </div>
    </div>

    {include file="$tpl_dir./errors.tpl"}
    <div class="text-center">
        <h1 class="h1 page-heading">{l s="It's done !"}</h1>
        <p>{l s='Thanks for your order #'} {$order->reference} . {l s='Your payment has been taken into account.'}</p>
    </div>

    <h5 class="page-subheading">{l s="This is what you'll get"}</h5>
    {include file="$tpl_dir./mobile/product-list.tpl" products=$products nb_products_per_line=3 isCarrousel=false}

    {if !Customer::hasRespondedOrderConfirmationPoll($cookie->id_customer)}
        <div id="googleForm">
            <a href="#" id="googleFormClose"><span class="icon-times"></span></a>
            <h5 class="page-subheading">{l s='Comment nous avez-vous connu?'}</h5>
            {include file="$tpl_dir./mobile/order-confirmation-sondage.tpl"}
        </div>
    {/if}

    <h5 class="page-subheading">{l s='Paiement'}</h5>
    <div class="text-right">
        <a class="invoice_link"
           href="{$link->getPageLink('pdf-invoice', true)}&submitAction=generateInvoicePDF&id_order_invoice={$order->invoice_number|intval}{if is_guest}&reference={$order->reference}&secure_key={$order->secure_key|escape:'html':'UTF-8'}{/if}">{l s='Download your invoice as a PDF file.'}</a>
    </div>
    <div class="text-center">
        {$HOOK_PAYMENT_RETURN}
    </div>

    <div>
        <div>
            <div class="text-justify">
                <h5 class="page-subheading">SUIVI EN TEMPS RÉEL</h5>
                <div>
                    Un email récapitulatif a été envoyé à votre adresse <b>{$email}</b> avec toutes les informations.
                </div>
                <div>
                    Nous vous informerons régulièrement par Email sur l'avancée de la fabrication et de l'acheminement
                    de votre commande.
                </div>
                <div>
                    Vous pouvez également suivre <b>en temps réel</b> l'état d'avancement de votre commande
                    depuis {if $is_guest}
                    <a href="{$link->getPageLink('guest-tracking', true, NULL, "id_order={$reference_order|urlencode}&email={$email|urlencode}")|escape:'html':'UTF-8'}"
                       title="{l s='Follow my order'}">votre espace client (rubrique "Mes commandes")</a>
                    {else}
                    <a href="{$link->getPageLink('history', true)|escape:'html':'UTF-8'}"
                       title="{l s='Go to your order history page'}">votre espace client (rubrique "Mes commandes")</a>
                    {/if}. Vous savez toujours où se trouve votre article, de sa fabrication à son acheminement vers nos
                    entrepôts, jusqu'a sa livraison à votre domicile !
                </div>
            </div>
        </div>
    </div>
    <div>
        <div>
            <h5 class="page-subheading">BESOIN D'INSPIRATION ?</h5>

            <div class="row gutter-10">
                <div class="col-xs-6 col-sm-6 style_toblog">
                    <div>
                        <a href="/blog">
                            <img src="/themes/default-bootstrap/img/home/NVG-Home-StyleInspiration.jpg"
                                 class="img-fluid">
                            <div class="white_block">
                                <img
                                        src="/themes/default-bootstrap/img/home/NVG-Home-StyleInspiration-Blog.png"
                                        class="img-fluid"/><span>Découvrez notre blog</span>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="col-xs-6 col-sm-6">En attendant votre commande, allez vite découvrir <a
                            href="http://monpotpourri.com/blog">notre Blog</a> avec plein
                    d'inspirations pour votre maison et n'oubliez pas de vous inscrire à notre Newsletter :
                </div>
            </div>
            <form class="form-inline"
                  action="{$link->getPageLink('index', null, null, null, false, null, true)|escape:'html':'UTF-8'}"
                  method="post">
                <div class="form-group">
                    <div class="input-group row gutter-10 valign-top">
                        <div class="col-xs-8">
                            <input type="email" class="form-control input-sm input-info" id="email" name="email"
                                   placeholder="Votre adresse email" required>
                        </div>
                        <div class="col-xs-4">
                            <span class="input-group-btn">
                                <button type="submit" name="submitNewsletter"
                                        class="btn btn-default btn-block">
                                    {l s='GO!' mod='blocknewsletter'}
                                </button>
                            </span>
                        </div>
                    </div>
                </div>
                <input type="hidden" name="action" value="0">
            </form>
        </div>
        <div>
            <h5 class="page-subheading">BESOIN D'AIDE ?</h5>
            <div>
                Notre #SuperServiceClient est là pour vous.<br/>
                Contactez-nous par email <strong><a
                            href="mailto:hello@monpotpourri.com">hello@monpotpourri.com</a></strong><br/>ou
                par téléphone au <strong><a href="tel:{Configuration::get('PS_SHOP_PHONE')}"
                                            class="phone_number">{Configuration::get('PS_SHOP_PHONE')}</a></strong><br/><br>
                Consultez <a href="/nous-connaitre/14-retours-remboursements">ici
                    nos modalités de retour</a></div>
        </div>
        <div>
            <h5 class="page-subheading">POUR MIEUX VOUS SATISFAIRE</h5>
            <div>Nous tenons à devenir toujours meilleurs pour mieux vous satisfaire !<br/>
                Dites-nous comment nous améliorer, nous vous écoutons !
            </div>
            <div>
                <form action="/nous-contacter" method="post">
                    <div class="row gutter-10">
                        <div class="form-group col-xs-8 col-sm-8">
                            <div>
                                <textarea class="form-control" id="message"
                                          name="message" placeholder="Votre message"></textarea>
                            </div>
                        </div>
                        <div class="form-group col-xs-4 col-sm-4">
                            <button type="submit" class="btn btn-default btn-block">Envoyer</button>
                            <input type="hidden" name="name" value="{$firstname}">
                            <input type="hidden" name="from" value="{$email}">
                            <input type="hidden" name="id_contact" value="9">
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!-- Google Code for test website page load conversion Conversion Page -->
    <script type="text/javascript">
        /* <![CDATA[ */
        var google_conversion_id = 919234443;
        var google_conversion_language = "en";
        var google_conversion_format = "3";
        var google_conversion_color = "ffffff";
        var google_conversion_label = "Al7NCOvM4mgQi8-ptgM";
        var google_conversion_value = {$order->total_products|@intval};
        var google_conversion_currency = "";
        var google_conversion_order_id = "{$order->reference}";
        var google_remarketing_only = false;
        /* ]]> */
    </script>
    <script type="text/javascript" src="//www.googleadservices.com/pagead/conversion.js">
    </script>
    <noscript>
        <div style="display:inline;">
            <img height="1" width="1" style="border-style:none;" alt=""
                 src="//www.googleadservices.com/pagead/conversion/919234443/?value={$order->total_products}&amp;currency_code=&amp;oid={$order->reference}&amp;label=Al7NCOvM4mgQi8-ptgM&amp;guid=ON&amp;script=0"/>
        </div>
    </noscript>
    {if $mercanet}
        {* Bon là c'est popur palier rapidement à un bug sur le retour de paiement mercanet.. *}
        <script>
            setTimeout(function () {
                window.location.href = window.location.href.replace('&mercanet=1', '');
            }, 500);
        </script>
    {/if}

</div>