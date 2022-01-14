package com.formskorea.console.config

import org.apache.ibatis.session.SqlSessionFactory
import org.mybatis.spring.SqlSessionFactoryBean
import org.mybatis.spring.SqlSessionTemplate
import org.mybatis.spring.annotation.MapperScan
import org.springframework.beans.factory.annotation.Qualifier
import org.springframework.boot.context.properties.ConfigurationProperties
import org.springframework.boot.jdbc.DataSourceBuilder
import org.springframework.context.ApplicationContext
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.jdbc.datasource.DataSourceTransactionManager
import org.springframework.transaction.annotation.EnableTransactionManagement
import javax.sql.DataSource

@Configuration
@EnableTransactionManagement
@MapperScan(value = ["com.formskorea.console.mapper.trend"], sqlSessionFactoryRef = "db3SqlSessionFactory")
class Db3Config {

    @Bean(name = ["db3DataSource"])
    @ConfigurationProperties(prefix = "spring.db3.datasource")
    fun db3DataSource(): DataSource {
        return DataSourceBuilder.create().build()
    }

    @Bean(name = ["db3SqlSessionFactory"])
    @Throws(Exception::class)
    fun db3SqlSessionFactory(@Qualifier("db3DataSource") db3DataSource: DataSource, applicationContext: ApplicationContext): SqlSessionFactory {
        val sqlSessionFactoryBean = SqlSessionFactoryBean()
        sqlSessionFactoryBean.setDataSource(db3DataSource)
        sqlSessionFactoryBean.setMapperLocations(applicationContext.getResources("classpath:mapper/trend/*.xml"))
        sqlSessionFactoryBean.setConfigLocation(applicationContext.getResource("classpath:mybatis-config.xml"))
        sqlSessionFactoryBean.setTypeAliasesPackage("com.formskorea.console.data.model")
        return sqlSessionFactoryBean.`object`!!
    }

    @Bean(name = ["db3SqlSessionTemplate"])
    @Throws(Exception::class)
    fun db3SqlSessionTemplate(db3SqlSessionFactory: SqlSessionFactory): SqlSessionTemplate {
        return SqlSessionTemplate(db3SqlSessionFactory)
    }

    @Bean
    fun db3transactionManager(): DataSourceTransactionManager {
        return DataSourceTransactionManager(db3DataSource())
    }
}