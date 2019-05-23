package dao.dao;

import dao.dto.*;
import java.util.*;

public interface ApplicationDtoDao{
    int insert(ApplicationDto a,int ver);
    int getAppIdByName(String name);
    int getAppverIdByAppIdAndVersion(int appId,int version);
    List<String> getAppByEmail(String email);
    String getAppNameFromAppId(int id);
    List<Integer> getAppIdByUserId(int userId);
    List<Integer> getVersionOfApp(String name);
}