<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="PersonalDetails.aspx.cs" Inherits="Admin_Master_PersonalDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
  
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
       <div class="row-fluid" id="for_other" style="display: block;">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Personal Details
            </h1>
        </div>
    </div>
  <div style="height:100%;min-height:80vh;">
  <iframe id="facultyFrame"
        src="FacultyDetails.aspx"
        style="width:100%;border:0;display:block;overflow:hidden"
        scrolling="no"></iframe>

<script>
(function () {
  const f = document.getElementById('facultyFrame');

  function resize() {
    if (!f.contentWindow || !f.contentDocument) return;
    const doc = f.contentDocument;
    const h = Math.max(
      doc.documentElement.scrollHeight,
      doc.body.scrollHeight,
      doc.documentElement.offsetHeight,
      doc.body.offsetHeight
    );
    f.style.height = h + 'px';
  }

  f.addEventListener('load', () => {
    resize();
    // Track content changes
    try {
      const ro = new ResizeObserver(resize);
      ro.observe(f.contentDocument.documentElement);
      f.contentWindow.addEventListener('resize', resize);
    } catch (_) {
      // Fallback poll (rarely needed)
      setInterval(resize, 600);
    }
  });
})();
</script>
</div>
</asp:Content>

