<head>
<title>ZVMODELVZ Web Manager</title>
<meta http-equiv="Content-Type" content="text/html; charset=Shift_JIS">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" type="text/css" href="style.css" media="screen"></link>
<script language="JavaScript" type="text/javascript" src="overlib.js"></script>
<script language="JavaScript" type="text/javascript" src="general.js"></script>
</head>  
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>    
<body onLoad="load_body()" onunLoad="return unload_body();">
<form method="GET" name="form" action="apply.cgi">
<!-- Table for the conntent page -->	    
<table width="666" border="0" cellpadding="0" cellspacing="0">     	      
    	
<input type="hidden" name="current_page" value="Main_WStatus_Content.asp"><input type="hidden" name="next_page" value="Main_WStatus_Content.asp"><input type="hidden" name="next_host" value=""><input type="hidden" name="sid_list" value="WLANConfig11a;WLANConfig11b;"><input type="hidden" name="group_id" value=""><input type="hidden" name="modified" value="0"><input type="hidden" name="action_mode" value=""><input type="hidden" name="first_time" value=""><input type="hidden" name="action_script" value="">
<tr>
<td>
<table width="666" border="1" cellpadding="0" cellspacing="0" bordercolor="E0E0E0">
<tr class="content_header_tr">
<td class="content_header_td_title" colspan="2">ステータスとログ - 11aインターフェイス</td>
</tr>
<tr class="content_header_tr">
<td colspan="2"><textarea class="content_log_td" cols="63" rows="10" wrap="off" readonly="1">
<% nvram_dump("wlan11a.log","wlan11a.sh"); %>              
            </textarea></td>
</tr>
</table>
</td>
</tr>
<tr>
<td>
<table width="666" border="1" cellpadding="0" cellspacing="0" bordercolor="E0E0E0">
<tr class="content_header_tr">
<td class="content_header_td_title" colspan="2">ステータスとログ - 11gインターフェイス</td>
</tr>
<tr class="content_header_tr">
<td colspan="2"><textarea class="content_log_td" cols="63" rows="10" wrap="off" readonly="1">
<% nvram_dump("wlan11b.log","wlan11b.sh"); %>              
            </textarea></td>
</tr>
</table>
</td>
</tr>
<tr>
<td>
<table width="666" border="2" cellpadding="0" cellspacing="0" bordercolor="E0E0E0"></table>
</td>
</tr>
<tr>
<td>
<table width="666" border="1" cellpadding="0" cellspacing="0" bordercolor="E0E0E0">
<tr>
<td class="content_header_td_less">無線コントロール:
           </td><td class="content_input_td"><input type="submit" maxlength="15" class="content_input_fd_ro" onClick="return onSubmitApply('radio_disable')" size="12" name="WLANConfig11b_WirelessCtrl_button" value="無効"><input type="submit" maxlength="15" class="content_input_fd_ro" onClick="return onSubmitApply('radio_enable')" size="12" name="WLANConfig11b_WirelessCtrl_button1" value="有効"></td>
</tr>
</table>
</td>
</tr>
<tr>
<td>
<table width="666" border="2" cellpadding="0" cellspacing="0" bordercolor="E0E0E0"></table>
</td>
</tr>
<tr>
<td>		
<table width="666" border="1" cellpadding="0" cellspacing="0" bordercolor="B0B0B0">
<tr bgcolor="#CCCCCC"><td colspan="3"><font face="arial" size="2"><b>&nbsp</b></font></td></tr>
<tr bgcolor="#FFFFFF">  
   <td height="25" width="34%">  
   </td>
   <td height="25" width="33%">  
   </td>
   <td height="25" width="33%">  
   <div align="center"><font face="Arial"> <input class=inputSubmit onMouseOut=buttonOut(this) onMouseOver="buttonOver(this)" onClick="onSubmitCtrl(this, ' Refresh ')" type="submit" value="リフレッシュ" name="action"></font></div> 
   </td>
</tr>
</table>
</td>
</tr>

</table>
</form>
</body>
