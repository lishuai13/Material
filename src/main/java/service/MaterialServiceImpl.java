package service;

import dao.MaterialDao;
import entity.Material;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

public class MaterialServiceImpl implements MaterialService{


    private MaterialDao materialDao;

    public void setMaterialDao(MaterialDao materialDao) {
        this.materialDao = materialDao;
    }

    @Transactional
    @Override
    public List<Material> test() {
        return materialDao.test();
    }

    @Transactional
    @Override
    public Material findMaterial(int id) {
        return materialDao.findMaterial(id);
    }

    @Transactional
    @Override
    public int deleteMaterial(int id) {
        return materialDao.deleteMaterial(id);
    }

    @Transactional
    @Override
    public int editMaterial(Map map) {
        return materialDao.editMaterial(map);
    }

    @Transactional
    @Override
    public int addMaterial(Map map) {
        return materialDao.addMaterial(map);
    }

    @Transactional
    @Override
    public String findMaxId() {
        return materialDao.findMaxId();
    }

    @Transactional
    @Override
    public List<Material> selectMaterial(Map map) {
        return materialDao.selectMaterial(map);
    }
}
