<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../include/subpages/utils.jsp" %>

<body class="g-sidenav-show   bg-gray-100">
  <%@ include file="../include/subpages/sidebar.jsp" %>

  <main class="main-content mt-1 border-radius-lg">
    <%@ include file="../include/subpages/header.jsp" %>

    <div class="container-fluid py-4">

      <!-- CONTENTS -->
      <div class="row my-4">
        <!-- CONTENT1 -->
        <div class="col-lg-4 col-md-6 mb-md-0 mb-4 mt-3">
          <div class="card">
            <div class="card-header pb-0">
              <div class="row">
                <div class="card-header pb-0 p-3">
                  <div class="row">
                    <div class="col-md-6 d-flex align-items-center">
                      <h6 class="mb-0">최신글</h6>
                    </div>
                    <div class="col-md-6 text-right" style="float:right;">
                      <a href="${path}/board/list" class="btn btn-outline-primary btn-sm mb-0">더 보기</a>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="card-body px-0 pb-2 mb-4">
              <div class="container">

                <ul class="list-group">
                  <c:forEach var="row" items="${list}">
                    <c:choose>
                      <c:when test="${row.show == 'y'}">
                        
                          <li class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            <a href="${path}/board/view?bno=${row.bno}&categoryid=${row.categoryid}" style="width:100%; display:block;">
                              [${row.categoryname}] ${row.title} 
                            
                              <c:if test="${row.recnt > 0}">
                                <span style="float:right;">
                                  <i class="far fa-comment-dots icon-red"> ${row.recnt}</i> &nbsp;
                                </span>
                              </c:if>
                            </a>  
                          </li>    

                      </c:when>
                      <c:otherwise>

                      </c:otherwise>
                    </c:choose> 
                  </c:forEach>         
                </ul>

              </div>
            </div>
          </div>
        </div>
        <!-- END CONTENT1 -->

        <!-- CONTENT 2 -->
        <div class="col-lg-4 col-md-6 mb-md-0 mb-4 mt-3">
          <div class="card">
            <div class="card-header pb-0">
              <div class="row">
                <div class="card-header pb-0 p-3">
                  <div class="row">
                    <div class="col-md-6 d-flex align-items-center">
                      <h6 class="mb-0">최신글</h6>
                    </div>
                    <div class="col-md-6 text-right" style="float:right;">
                      <a href="${path}/board/list" class="btn btn-outline-primary btn-sm mb-0">더 보기</a>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="card-body px-0 pb-2 mb-4">
              <div class="container">

                <ul class="list-group">
                  <c:forEach var="row" items="${list}">
                    <c:choose>
                      <c:when test="${row.show == 'y'}">
                        
                          <li class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            <a href="${path}/board/view?bno=${row.bno}" style="width:100%; display:block;">
                              [${row.categoryname}] ${row.title} 
                            
                              <c:if test="${row.recnt > 0}">
                                <span style="float:right;">
                                  <i class="far fa-comment-dots icon-red"> ${row.recnt}</i> &nbsp;
                                </span>
                              </c:if>
                            </a>  
                          </li>    

                      </c:when>
                      <c:otherwise>

                      </c:otherwise>
                    </c:choose> 
                  </c:forEach>         
                </ul>

              </div>
            </div>
          </div>
        </div>
        <!-- END CONTENT2 -->        

        <!-- CONTENT 3 -->
        <div class="col-lg-4 col-md-6 mb-md-0 mb-4 mt-3">
          <div class="card">
            <div class="card-header pb-0">
              <div class="row">
                <div class="card-header pb-0 p-3">
                  <div class="row">
                    <div class="col-md-6 d-flex align-items-center">
                      <h6 class="mb-0">최신글</h6>
                    </div>
                    <div class="col-md-6 text-right" style="float:right;">
                      <a href="${path}/board/list" class="btn btn-outline-primary btn-sm mb-0">더 보기</a>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="card-body px-0 pb-2 mb-4">
              <div class="container">

                <ul class="list-group">
                  <c:forEach var="row" items="${list}">
                    <c:choose>
                      <c:when test="${row.show == 'y'}">
                        
                          <li class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            <a href="${path}/board/view?bno=${row.bno}" style="width:100%; display:block;">
                              [${row.categoryname}] ${row.title} 
                            
                              <c:if test="${row.recnt > 0}">
                                <span style="float:right;">
                                  <i class="far fa-comment-dots icon-red"> ${row.recnt}</i> &nbsp;
                                </span>
                              </c:if>
                            </a>  
                          </li>    

                      </c:when>
                      <c:otherwise>

                      </c:otherwise>
                    </c:choose> 
                  </c:forEach>         
                </ul>

              </div>
            </div>
          </div>
        </div>
        <!-- END CONTENT3 --> 

        <!-- CONTENT 4 -->
        <div class="col-lg-4 col-md-6 mb-md-0 mb-4 mt-3">
          <div class="card">
            <div class="card-header pb-0">
              <div class="row">
                <div class="card-header pb-0 p-3">
                  <div class="row">
                    <div class="col-md-6 d-flex align-items-center">
                      <h6 class="mb-0">최신글</h6>
                    </div>
                    <div class="col-md-6 text-right" style="float:right;">
                      <a href="${path}/board/list" class="btn btn-outline-primary btn-sm mb-0">더 보기</a>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="card-body px-0 pb-2 mb-4">
              <div class="container">

                <ul class="list-group">
                  <c:forEach var="row" items="${list}">
                    <c:choose>
                      <c:when test="${row.show == 'y'}">
                        
                          <li class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            <a href="${path}/board/view?bno=${row.bno}" style="width:100%; display:block;">
                              [${row.categoryname}] ${row.title} 
                            
                              <c:if test="${row.recnt > 0}">
                                <span style="float:right;">
                                  <i class="far fa-comment-dots icon-red"> ${row.recnt}</i> &nbsp;
                                </span>
                              </c:if>
                            </a>  
                          </li>    

                      </c:when>
                      <c:otherwise>

                      </c:otherwise>
                    </c:choose> 
                  </c:forEach>         
                </ul>

              </div>
            </div>
          </div>
        </div>
        <!-- END CONTENT4 -->         

      </div>     

      <!-- END CONTENTS -->    

      <%@ include file="../include/subpages/footer.jsp" %>

    </div>

  </main>
  <div class="fixed-plugin">
    <a class="fixed-plugin-button text-dark position-fixed px-3 py-2">
      <i class="fa fa-cog py-2"> </i>
    </a>
    <div class="card shadow-lg ">
      <div class="card-header pb-0 pt-3 ">
        <div class="float-start">
          <h5 class="mt-3 mb-0">Soft UI Configurator</h5>
          <p>See our dashboard options.</p>
        </div>
        <div class="float-end mt-4">
          <button class="btn btn-link text-dark p-0 fixed-plugin-close-button">
            <i class="fa fa-close"></i>
          </button>
        </div>
        <!-- End Toggle Button -->
      </div>
      <hr class="horizontal dark my-1">
      <div class="card-body pt-sm-3 pt-0">
        <!-- Sidebar Backgrounds -->
        <div>
          <h6 class="mb-0">Sidebar Colors</h6>
        </div>
        <a href="javascript:void(0)" class="switch-trigger background-color">
          <div class="badge-colors my-2 text-start">
            <span class="badge filter bg-gradient-primary active" data-color="primary" onclick="sidebarColor(this)"></span>
            <span class="badge filter bg-gradient-dark" data-color="dark" onclick="sidebarColor(this)"></span>
            <span class="badge filter bg-gradient-info" data-color="info" onclick="sidebarColor(this)"></span>
            <span class="badge filter bg-gradient-success" data-color="success" onclick="sidebarColor(this)"></span>
            <span class="badge filter bg-gradient-warning" data-color="warning" onclick="sidebarColor(this)"></span>
            <span class="badge filter bg-gradient-danger" data-color="danger" onclick="sidebarColor(this)"></span>
          </div>
        </a>
        <!-- Sidenav Type -->
        <div class="mt-3">
          <h6 class="mb-0">Sidenav Type</h6>
          <p class="text-sm">Choose between 2 different sidenav types.</p>
        </div>
        <div class="d-flex">
          <button class="btn bg-gradient-primary w-100 px-3 mb-2 active" data-class="bg-transparent" onclick="sidebarType(this)">Transparent</button>
          <button class="btn bg-gradient-primary w-100 px-3 mb-2 ms-2" data-class="bg-white" onclick="sidebarType(this)">White</button>
        </div>
        <p class="text-sm d-xl-none d-block mt-2">You can change the sidenav type just on desktop view.</p>
        <!-- Navbar Fixed -->
        <div class="mt-3">
          <h6 class="mb-0">Navbar Fixed</h6>
        </div>
        <div class="form-check form-switch ps-0">
          <input class="form-check-input mt-1 ms-auto" type="checkbox" id="navbarFixed" onclick="navbarFixed(this)">
        </div>
        <hr class="horizontal dark my-sm-4">
        <a class="btn bg-gradient-dark w-100" href="https://www.creative-tim.com/product/soft-ui-dashboard">Free download</a>
        <a class="btn btn-outline-dark w-100" href="https://www.creative-tim.com/learning-lab/bootstrap/license/soft-ui-dashboard">View documentation</a>
        <div class="w-100 text-center">
          <a class="github-button" href="https://github.com/creativetimofficial/soft-ui-dashboard" data-icon="octicon-star" data-size="large" data-show-count="true" aria-label="Star creativetimofficial/soft-ui-dashboard on GitHub">Star</a>
          <h6 class="mt-3">Thank you for sharing!</h6>
          <a href="https://twitter.com/intent/tweet?text=Check%20Soft%20UI%20Dashboard%20made%20by%20%40CreativeTim%20%23webdesign%20%23dashboard%20%23bootstrap5&amp;url=https%3A%2F%2Fwww.creative-tim.com%2Fproduct%2Fsoft-ui-dashboard" class="btn btn-dark mb-0 me-2" target="_blank">
            <i class="fab fa-twitter me-1" aria-hidden="true"></i> Tweet
          </a>
          <a href="https://www.facebook.com/sharer/sharer.php?u=https://www.creative-tim.com/product/soft-ui-dashboard" class="btn btn-dark mb-0 me-2" target="_blank">
            <i class="fab fa-facebook-square me-1" aria-hidden="true"></i> Share
          </a>
        </div>
      </div>
    </div>
  </div>

  <%@ include file="../include/subpages/footerScript.jsp" %>
  
</body>

</html>