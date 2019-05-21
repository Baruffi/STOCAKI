package DAO;

import java.sql.*;
import java.util.*;

public class RequisicaoDAO {

    private static final DataConnection dataConnection = new DataConnection();
    private static final String SELECT = "SELECT * FROM Requisicao";

    public static void displayRequisicoes() {
        /*
        TODO
            display data from table Requisicao

        HashMap<Integer,String> requisicaoMap = new HashMap<Integer, String>();
        requisicaoMap.put(row, rs.getString("id_requisicao"));
        requisicaoMap.put(row, rs.getString("status_aprovacao"));
        requisicaoMap.put(row, rs.getString("descricao"));
        requisicaoMap.put(row, rs.getString("classificacao"));
        requisicaoMap.put(row, rs.getString("modelo"));
        requisicaoMap.put(row, rs.getString("lote"));
        requisicaoMap.put(row, rs.getString("cor"));
        requisicaoMap.put(row, rs.getString("sessao"));
        requisicaoMap.put(row, rs.getString("saldo"));
        */
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            int row;
            con = dataConnection.getConnection();
            ps = con.prepareStatement(SELECT);
            rs = ps.executeQuery();

            while (rs.next()) {
                row = rs.getRow();
            }
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            dataConnection.closeConnection(con, ps, rs);
            // return data
        }
    }
}
