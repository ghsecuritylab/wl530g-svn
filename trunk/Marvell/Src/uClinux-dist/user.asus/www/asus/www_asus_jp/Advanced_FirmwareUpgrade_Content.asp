<head>
<title>ZVMODELVZ Web Manager</title>
<meta http-equiv="Content-Type" content="text/html; charset=Shift_JIS">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta http-equiv="Content-Type" content="text/html">
<link rel="stylesheet" type="text/css" href="style.css" media="screen">
<script language="JavaScript" type="text/javascript" src="overlib.js"></script>
<script language="JavaScript" type="text/javascript" src="general.js"></script>
<script language="JavaScript" type="text/javascript" src="quick.js"></script>
</head>  
<body bgcolor="#FFFFFF" onload="load_upload()">
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>    
<form method="post" action="upgrade.cgi" name="form" enctype="multipart/form-data">
<!-- Table for the conntent page -->	    
<table width="660" border="0" cellpadding="1" cellspacing="0">     	      
    	
<tr>
<td>
<table width="666" border="2" cellpadding="0" cellspacing="0" bordercolor="E0E0E0">
<tr class="content_header_tr">
<td class="content_header_td_title" colspan="2">�V�X�e���Z�b�g�A�b�v - �t�@�[���E�F�A�̃A�b�v�O���[�h</td>
<input type="hidden" name="current_page" value="Basic_Operation_Content.asp">
<input type="hidden" name="next_page" value="Basic_SaveRestart.asp">
<input type="hidden" name="action_mode" value="">
</tr>
<tr class="content_section_header_tr">
<td id="Mode" class="content_section_header_td" colspan="2" width="614"> �ȉ��Ƀ��X�g�A�b�v����w���ɏ]���Ă�������:</td>
</tr>

<tr>
<td class="content_desc_td" colspan="2" width="614">
              	<ol>
              		<li>
              <p style="margin-top: 7">
                    �t�@�[���E�F�A�̐V�����o�[�W������ASUS��Web�T�C�g�Ŏg�p�ł��邩�`�F�b�N���܂��B
              </li>
              		<li>
              <p style="margin-top: 7">
                    �K�؂ȃo�[�W���������[�J���}�V���Ƀ_�E�����[�h���܂��B               
              </li>
              		<li>
              <p style="margin-top: 7">
                    �_�E�����[�h�����t�@�C���̃p�X�Ɩ��O���ȉ��́u�V�����t�@�[���E�F�A�t�@�C���v�Ŏw�肵�܂��B
              </li>
              		<li>
              <p style="margin-top: 7">
                    �u�A�b�v���[�h�v���N���b�N���āA�t�@�C����ZVMODELVZ�ɃA�b�v���[�h���܂��B����ɂ͖�10�b������܂��B
              </li>
              <li>
              <p style="margin-top: 7">
                    �������t�@�[���E�F�A�t�@�C�����󂯎������AZVMODELVZ�̓A�b�v�O���[�h�v���Z�X�������I�ɊJ�n���܂��B�v���Z�X���I�����Ă���V�X�e�����ċN������܂ŁA�������Ԃ�������܂��B
 	      </li>
              </ol>
</td>
</tr>
<tr>
		<td class="content_header_td" width="30">���iID:</td><td class="content_input_td" width="595"><input type="text" value="<% nvram_get_f("general.log","productid"); %>" readonly="1"></td>
</tr>
<tr>
		<td class="content_header_td" width="30">�t�@�[���E�F�A�o�[�W����:</td><td class="content_input_td" width="595"><input type="text" value="<% nvram_get_f("general.log","firmver"); %>" readonly="1"></td>
</tr>
<tr>
<td class="content_header_td" width="30">�V�����t�@�[���E�F�A�t�@�C��:</td><td class="content_input_td">  
                  <input class="inputSubmit" name="file" size="20" type="file" ></td>
</tr>
<tr>
<td class="content_header_td"></td><td class="content_input_td" width="595">
  <p align="left"><input class="inputSubmit" name="button" onClick="onSubmitCtrlOnly(this, 'Upload1')" type="button" value="�A�b�v���[�h"> 
  </p>
</td>
</tr>
<tr>
<td class="content_desc_td" colspan="2" width="614">
	             <b>��:</b>
                     <ol>
                     	<li>�V�������̃t�@�[���E�F�A�ɂ���ݒ�p�����[�^�ɂƂ��āA���̐ݒ�̓A�b�v�O���[�h�v���Z�X�̊Ԉێ�����܂��B</li>
                     	<li>�A�b�v�O���[�h�v���Z�X�����s����ƁAZVMODELVZ�͎����I�ɋً}���[�h�ɓ���܂��BZVMODELVZ�O�ʂɂ���LED�M���͂��̂悤�ȏ󋵂������܂��BCD�̃t�@�[���E�F�A�C�����[�e�B���e�B���g�p���āA�V�X�e���C�������s���Ă��������B</li>
                     </ol>
</td>
</tr>
</table>
</td>
</tr>
</table>
</form>
</body>