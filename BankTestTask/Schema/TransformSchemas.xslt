<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
<xsl:output method="html"/>
<xsl:decimal-format name="dkk" decimal-separator="." grouping-separator=","/>
<xsl:template match="/">
<xsl:for-each select="/Result/CardList/Card">
<div class="panel panel-default">
<div class="panel-body">
            <b>Название карты</b><b style="float: right;"><xsl:value-of select="CardInfo/CardProdName"/></b>
            <hr class="custom-hr"/>
            <b>Номер карты</b><b style="float: right;"><xsl:value-of select="CardInfo/CardNumber"/></b>
            <hr class="custom-hr"/>
            <br/>
            <hr class="custom-hr"/>
            <span>Валюта:</span><span style="float: right;"><xsl:value-of select="CardInfo/CardCurISO"/></span>
            <hr class="custom-hr"/>
            <span>Имя счета:</span><span style="float: right;"><xsl:value-of select="CardInfo/AccTypeName"/></span>
            <hr class="custom-hr"/>
            <span>Дата выпуска карты:</span><span style="float: right;"><xsl:value-of select="CardInfo/CardOpenDate"/></span>
            <hr class="custom-hr"/>
            <span>Срок окончания действия карты:</span><span style="float: right;"><xsl:value-of select="CardInfo/CardTermDate"/></span>
            <hr class="custom-hr"/>
            <span>Статус карты:</span><span style="float: right;"><xsl:value-of select="CardInfo/CardStatusName"/></span>
            <hr class="custom-hr"/>
            <span>ФИО владельца карт-счета:</span><span style="float: right;"><xsl:value-of select="CardInfo/CardHolder"/></span>
            <hr class="custom-hr"/>
			<table class="table table-striped table-responsive" style="font-size: 14pt;">
                <thead>
                <tr style="background-color: darkgreen; color: white;">
                    <th class="tbl-head">Номер транзакции</th>
                    <th class="tbl-head">Время транзакции</th>
                    <th class="tbl-head">Тип операции</th>
                    <th class="tbl-head">Статус операции</th>
                    <th class="tbl-head">Сумма в валюте операции</th>
                    <th class="tbl-head">Место</th>
                    <th class="tbl-head">Страна</th>
                    <th class="tbl-head">Детализация</th>
                </tr>
                </thead>
                <tbody>
				<xsl:for-each select="CardTransactions/Transaction">
                <tr>
                    <td class="tbl-rows"><xsl:value-of select="ID"/></td>
                    <td class="tbl-rows"><xsl:value-of select="TransDate"/></td>
                    <td class="tbl-rows"><xsl:value-of select="TransTypeName"/></td>
                    <td class="tbl-rows"><xsl:value-of select="CategoryName"/></td>
                    <td class="tbl-rows"><xsl:value-of select="format-number(Ammount, '#,###.00 ', 'dkk')"/><span>  </span><xsl:value-of select="Currency"/></td>
                    <td class="tbl-rows"><xsl:value-of select="City"/></td>
                    <td class="tbl-rows"><xsl:value-of select="Country"/></td>
                    <td class="tbl-rows"><xsl:value-of select="Details"/></td>
                </tr>
				</xsl:for-each>
                </tbody>
            </table>
</div>
</div>
<br/>
<br/>
</xsl:for-each>
</xsl:template>
</xsl:stylesheet>