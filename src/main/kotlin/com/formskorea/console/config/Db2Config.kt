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
import org.springframework.context.annotation.Primary
import org.springframework.jdbc.datasource.DataSourceTransactionManager
import org.springframework.transaction.annotation.EnableTransactionManagement
import javax.sql.DataSource

@Configuration
@EnableTransactionManagement
@MapperScan(value = ["com.formskorea.console.mapper.log"], sqlSessionFactoryRef = "db2SqlSessionFactory")
class Db2Config {

    @Bean(name = ["db2DataSource"])
    @ConfigurationProperties(prefix = "spring.db2.datasource")
    fun db2DataSource(): DataSource {
        return DataSourceBuilder.create().build()
    }

    @Bean(name = ["db2SqlSessionFactory"])
    @Throws(Exception::class)
    fun db2SqlSessionFactory(@Qualifier("db2DataSource") db2DataSource: DataSource, applicationContext: ApplicationContext): SqlSessionFactory {
        val sqlSessionFactoryBean = SqlSessionFactoryBean()
        sqlSessionFactoryBean.setDataSource(db2DataSource)
        sqlSessionFactoryBean.setMapperLocations(applicationContext.getResources("classpath:mapper/log/*.xml"))
        sqlSessionFactoryBean.setConfigLocation(applicationContext.getResource("classpath:mybatis-config.xml"))
        sqlSessionFactoryBean.setTypeAliasesPackage("com.formskorea.console.data.model")
        return sqlSessionFactoryBean.`object`!!
    }

    @Bean(name = ["db2SqlSessionTemplate"])
    @Throws(Exception::class)
    fun db2SqlSessionTemplate(db2SqlSessionFactory: SqlSessionFactory): SqlSessionTemplate {
        return SqlSessionTemplate(db2SqlSessionFactory)
    }

    @Bean
    fun transactionManager(): DataSourceTransactionManager {
        return DataSourceTransactionManager(db2DataSource())
    }
}