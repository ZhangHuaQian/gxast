package com.cen.common.util;

import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.Map;

public interface FileUtilImpl {
    public Map<String,Object> fileUpLoad(MultipartFile file, String basePath);

    public File fileDownLoad(String sources,String basePath);
}
