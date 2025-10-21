public interface Model {
    void getAll();
    void getId(Integer id);
    void updateRowId(Integer id, String[] newValues);
    void deleteRowId(Integer id);
    void insertNewRow(String[] values);
}