<%@include file="tags.jsp"%>
<c:set var="biasingProfileCount" value="${model.biasingProfileCount}"/>
<c:set var="width" value="${100/biasingProfileCount}"/>
<div id="scratchArea" style="display: none;"></div>
<table style="margin-left:10px;"><tr>

<c:forEach begin="0" end="${biasingProfileCount -1}" varStatus="b">
<c:set var="name" value="results${b.index}"/>
<c:set var="results" value="${model[name]}"/>
<td class="recordColumn" style="padding-right:10px;" valign="top" width="width:${width}%">

<c:set var="index" value="${b.index}"/>
<%@include file="debug.jsp"%>
<div class="resultBiasAndCount">
<input type="text" id="biasing${b.index}" value="${results.biasingProfile}" placeholder="Biasing Profile" style="width:120px;">
<c:if test="${b.index > 0}">
<a href="javascript:;" onclick="removeColumn(${b.index});">-</a>
</c:if>
<a href="javascript:;" onclick="addColumn(${b.index})">+</a>
<div class="totalRecordCountTitle">Total Record Count:</div><div class="totalRecordCount"> ${results.totalRecordCount}</div>
</div>

<BR>
<div class="resultMatchStrategy">
	<a href="javascript:;" class="leftMatchStrategy" onclick="exactMatchStrategy(${b.index})">Exact Match Strategy</a>
	<a href="javascript:;" class="rightMatchStrategy" onclick="resetMatchStrategy(${b.index})">Default Match Strategy</a><br>
<textarea id="matchStrategy${b.index}" value="${results.matchStrategy}" placeholder="[{ 'terms': 2, 'mustMatch': 2 }, { 'terms': 3, 'mustMatch': 2 }, { 'terms': 4, 'mustMatch': 3 }, { 'terms': 5, 'mustMatch': 3 }, { 'terms': 6, 'mustMatch': 4 }, { 'terms': 7, 'mustMatch': 4 }, { 'terms': 8, 'mustMatch': 5 }, { 'termsGreaterThan': 8, 'mustMatch': 60, 'percentage': true }]" rows=5 style="width:100%">${results.matchStrategy}</textarea><br>
</div>


<ol id="replacementRow${b.index}" style="display: none">

</ol>


<ol id="row${b.index}">
<%@include file="record.jsp"%>
</ol>

</c:forEach>
  </td>  </tr></table>
<script>

    $('.highlightCorresponding').mouseenter(function() {
        var matchingRecords = $(this).attr('data-id').substring(5);
        $('.' + matchingRecords).addClass('highlight');
    }).mouseleave(function(){
        $('.highlightCorresponding').removeClass('highlight');
    });

    $('.recordColumn input').keyup(function(e){
        var code = (e.keyCode ? e.keyCode : e.which);
        if (code == 13) {
            e.preventDefault();
            e.stopPropagation();
            saveForm();
            $('#form').submit();
        } else {
            var biasings = '';
            $('.recordColumn input').each(function(){
                biasings += $(this).val() +  ","
            });
            biasings = biasings.substring(0, biasings.length-1);
            $('#biasingProfile').val(biasings);
            $('#biasingProfile').trigger('change');
        }
    });

    $('.recordColumn textarea').keydown(function(e){
	    var matchStrategies = '';
            $('.recordColumn textarea').each(function(){
                matchStrategies += $(this).val() +  "|"
            });
            matchStrategies = matchStrategies.substring(0, matchStrategies.length-1);
            $('#matchStrategy').val(matchStrategies);
            $('#matchStrategy').trigger('change');
        var code = (e.keyCode ? e.keyCode : e.which);
        if (code == 13) {
            e.preventDefault();
            e.stopPropagation();
            saveForm();
            $('#form').submit();
	} 
    });
    
    function removeColumn(pIndex){
        $('#biasing' + pIndex).parent().hide('slide');
        $('#biasing' + pIndex).remove();
        $('.recordColumn input').trigger('keyup');
        saveForm();
        $('#form').submit();
    }
    function addColumn(pIndex){
        var oldValue = $('#biasingProfile').val();
        var newValue = oldValue + ',' + $('#biasing' + pIndex).val();
        $('#biasingProfile').val(newValue);
        $('#biasingProfile').trigger('change');
        saveForm();
        $('#form').submit();
    }

    function resetMatchStrategy(pIndex){
	    document.getElementById("matchStrategy"+pIndex).value="[{ 'terms': 2, 'mustMatch': 2 }, { 'terms': 3, 'mustMatch': 2 }, { 'terms': 4, 'mustMatch': 3 }, { 'terms': 5, 'mustMatch': 3 }, { 'terms': 6, 'mustMatch': 4 }, { 'terms': 7, 'mustMatch': 4 }, { 'terms': 8, 'mustMatch': 5 }, { 'termsGreaterThan': 8, 'mustMatch': 60, 'percentage': true }]";
	    saveForm();
	    var matchStrategies = '';
            $('.recordColumn textarea').each(function(){
                matchStrategies += $(this).val() +  "|";
            });
            matchStrategies = matchStrategies.substring(0, matchStrategies.length-1);
            $('#matchStrategy').val(matchStrategies);
            $('#matchStrategy').trigger('change');
            saveForm();
            $('#form').submit();
    }

    function exactMatchStrategy(pIndex){
	    document.getElementById("matchStrategy"+pIndex).value="[{ 'termsGreaterThan': 1, 'mustMatch': 100, 'percentage': true }]";
	    saveForm();
	    var matchStrategies = '';
            $('.recordColumn textarea').each(function(){
                matchStrategies += $(this).val() +  "|";
            });
            matchStrategies = matchStrategies.substring(0, matchStrategies.length-1);
            $('#matchStrategy').val(matchStrategies);
            $('#matchStrategy').trigger('change');
            saveForm();
            $('#form').submit();
    }
</script>