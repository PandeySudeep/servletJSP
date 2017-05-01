package aafnai.hamrai.filters;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet Filter implementation class Logout
 */
@WebFilter("/Logout")
public class Logout implements Filter {

    private FilterConfig fc;
	/**
     * Default constructor. 
     */
    public Logout() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		
		
		
		HttpServletRequest httpreq = (HttpServletRequest)request;
		HttpServletResponse httpres = (HttpServletResponse)response;
		
		PrintWriter out = httpres.getWriter();
		
		HttpSession session = httpreq.getSession();
		String usr = (String)session.getAttribute("sessionattr");
		if(usr==null){
		//	out.print("logged out");
		request.setAttribute("message", "Your session has expired. Please click on the 'Back' button to the left of this page and log in again to start"
					+ "a new session.");
			request.setAttribute("link", "welcome.jsp");
			RequestDispatcher view = request.getRequestDispatcher("msg_display.jsp");
			view.forward(request,response);
			
		}
		
		
		// TODO Auto-generated method stub
		// place your code here

		// pass the request along the filter chain
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
		this.fc=fConfig;
	}

}
