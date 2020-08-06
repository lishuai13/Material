package dao;

import entity.Material;

import java.util.List;
import java.util.Map;

public interface MaterialDao {

    List<Material> test();

    Material findMaterial(int id);

    int deleteMaterial(int id);

    int editMaterial(Map map);

    int addMaterial(Map map);

    String findMaxId();

    List<Material> selectMaterial(Map map);

}
