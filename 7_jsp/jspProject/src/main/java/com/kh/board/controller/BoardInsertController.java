package com.kh.board.controller;

import java.io.IOException;

import com.oreilly.servlet.MultipartRequest;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class BoardInsertController
 */
public class BoardInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardInsertController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		//일반방식이 아닌 multipart/form-data로 전송하는 경우 request로 부터 값 추출 불가
		//String boardTitle = request.getParameter("title");
		//System.out.println(boardTitle);
		
		//enctype이 multipart/form-data로 전송이 되었는지 체크
		
		//파일업로드를 위한 라이브러리 cos.jar
		//maven 저장소에서 다운로드
		
		//1. 파일 용량제한(byte)
		// byte -> kbyte -> mbyte -> gbyte -> tbyte ...
		int maxSize = 1024 * 1024 * 10; //10mb
		
		//2. 전달된 파일을 저장시킬 폴더경로 가져오기
		String savePath = request.getSession().getServletContext().getRealPath("/resources/board_upfile/");
		
		//new MultipartRequest(request, 저장시킬 폴더의 경로, 용량제한, 인코딩, 이름을 어떻게 변경할지 정해둔 객체)
		MultipartRequest mutiRequest = MultipartRequest(request, savePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}